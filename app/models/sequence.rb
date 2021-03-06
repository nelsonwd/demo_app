class Sequence < ActiveRecord::Base
  belongs_to :blast_db
  has_many :features,  :dependent => :destroy
  has_many :de_data,  :dependent => :destroy
  has_many :annotations, :through => :features
  has_and_belongs_to_many :leaders
  has_many :go_slim_sequences

#  def Sequence.parse_accession(desc, blast_index)
#    parts = desc.split("_")
#    versions = parts[3].split("/")
#    accession = blast_index + '_' + parts[1] 
#    description = "Transcript #{versions[0]} of #{versions[1]}; Confidence #{parts[5]}; Length #{parts[7]}"
#    [accession, description]
#  end

  def Sequence.parse_accession(desc)
    parts = desc.split()
    [parts.shift, parts.join(" ")]
  end

  def Sequence.run(fasta_file)
    file = Bio::FlatFile.open(Bio::FastaFormat, "#{Rails.root}/public/fasta/#{fasta_file}")
    db_id = BlastDb.where(:file_name => fasta_file).first
    file.each_entry do |f|
      accession, description = Sequence.parse_accession(f.definition)
      puts ">#{accession} #{db_id.id} #{description}"
      Sequence.find_or_create_by_accession(accession, :name => nil, :description => description, :na_seq => f.naseq.upcase , :blast_db_id => db_id.id )
     end
  end


  def na_to_html frame_number
    CdsMapper.new(self).na_to_html frame_number
  end

  def aa_to_html frame_number
    CdsMapper.new(self).aa_to_html frame_number
  end

end

class CdsMapper
  attr_accessor :leader_seq
  LEADERS=%w(GCCGTAGCCATTTTGGCTCAAG
             ACCGTAGCCATTTTGGCTCAAG
             TCCGTAGCCATTTTGGCTCAAG
              CCGTAGCCATTTTGGCTCAAG
               CGTAGCCATTTTGGCTCAAG
                GTAGCCATTTTGGCTCAAG
                 TAGCCATTTTGGCTCAAG
                  AGCCATTTTGGCTCAAG
                   GCCATTTTGGCTCAAG
                    CCATTTTGGCTCAAG
                     CATTTTGGCTCAAG
                      ATTTTGGCTCAAG
                       TTTTGGCTCAAG)

  def initialize(sequence)
    @na_seq = Bio::Sequence::NA.new(sequence.na_seq)
    @sequence = sequence
    @maps = []
    map_cds
    @leader_seq = map_leader
    #puts @leader_seq
  end

  def map_cds
    1.upto(6).each do |i|  #frame loop
      aa_sequence = @na_seq.translate(i)
      start_marker = cds_len = 0
      cds_map = CdsMap.new i, nil, nil, @na_seq.size
      while true
        if (start_codon = aa_sequence.index(?M, start_marker))
          if end_codon = aa_sequence.index(?*, start_codon + 1)
            start_marker = end_codon
            if (end_codon - start_codon - 1) == 0
              next
            else
              if cds_len < (end_codon - start_codon -1)
                cds_len =  end_codon - start_codon -1
                cds_map = CdsMap.new i, start_codon, end_codon, @na_seq.size
              end
            end
          else
            break
          end
        else
          break
        end
      end
      @maps[i - 1] = cds_map
    end
  end

  def map_leader
    @leader_seq = LEADERS.select {|l| @na_seq.upcase.match /#{l}/}.first
    if @leader_seq.nil?
     @leader_seq = LEADERS.select {|l| @na_seq.reverse_complement.upcase.match /#{l}/}.first
    end
    @leader_seq
  end


  def aa_to_s frame
    aa_s = @na_seq.translate(frame.to_i).to_s
    aa_s
  end

  def na_to_s  frame
    if frame.to_i < 4
      @na_seq.to_s.upcase
    else
      @na_seq.complement.to_s.upcase
    end
  end

  def na_to_html frame
    seq = mark_leader na_to_s(frame)
    return wrap( seq ,80)  unless is_valid? frame

    na = "<span style=\"color:green\" >#{utr_5_na frame}</span>"
    na += "<span style=\"color:red\" >#{start_na(frame)}</span>"
    na += "<span style=\"color:blue\" >#{cds_na(frame)}</span>"
    na += "<span style=\"color:red\" >#{stop_na(frame)}</span>"
    na += "<span style=\"color:green\" >#{utr_3_na(frame)}</span>"
    na = mark_leader na
    wrap na, 80
  end

  def aa_to_html frame
    return wrap(aa_to_s(frame),80)  unless is_valid? frame

    aa = "<span style=\"color:green\" >#{utr_n_aa frame}</span>"
    aa += "<span style=\"color:red\" >#{start_aa(frame)}</span>"
    aa += "<span style=\"color:blue\" >#{cds_aa(frame)}</span>"
    aa += "<span style=\"color:red\" >#{stop_aa(frame)}</span>"
    aa += "<span style=\"color:green\" >#{utr_c_aa(frame)}</span>"
    wrap aa, 80
  end

  def mark_leader  na_seq
    if @leader_seq
      na_seq.gsub! @leader_seq, "<span style=\"color:orange\" >#{@leader_seq}</span>"
    end
    na_seq
  end

  def start_aa frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    aa_to_s(frame)[map.start_aa, 1 ]
  end

  def start_na frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    na_to_s(frame)[map.start_na, 3 ]
  end

  def stop_na frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    na_to_s(frame)[map.end_na, 3 ]
  end

  def stop_aa frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    aa_to_s(frame)[map.end_aa, 1 ]
  end


  def utr_5_na frame
    return '' unless is_valid? frame
    na_to_s(frame)[0, utr_5_na_size(frame) ]

  end

  def utr_n_aa frame
    return '' unless is_valid? frame
    aa_to_s(frame)[0, utr_n_aa_size(frame) ]

  end

  def utr_5_na_size frame
    @maps[frame.to_i - 1].utr_5_na_size
  end

  def utr_n_aa_size frame
    @maps[frame.to_i - 1].utr_n_aa_size
  end

  def utr_3_na frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    utr_start = map.end_na + 3
    seq = na_to_s(frame)
    seq[utr_start, seq.size - utr_start]
  end

  def utr_c_aa frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    seq = aa_to_s(frame)
    seq[map.end_aa, seq.size - map.end_aa]
  end

  def cds_na  frame
    return '' unless  is_valid? frame
    map =  @maps[frame.to_i - 1]
    cds_na_start = map.start_na + 3
    na_to_s(frame)[cds_na_start,map.cds_na_size]
  end

  def cds_aa  frame
    return '' unless  is_valid? frame
    map =  @maps[frame.to_i - 1]
    cds_aa_start = map.start_aa
    aa_to_s(frame)[cds_aa_start,map.cds_aa_size]
  end

  def is_valid? frame
    @maps[frame.to_i - 1].is_valid?
  end

  #formats a fasta entry to row_len residues per line, while ignoring hidden html formatting tags.
  def wrap seq, row_len
    count = 0
    returnString = ''
    html = false
    (0..seq.size - 1).each do |c|
      returnString << seq[c]
      if seq[c] == ?<
        html = true
      elsif seq[c] == ?>
        html = false
        next
      elsif html
        next
      else
        count +=1
        if count == row_len
          returnString << '<br>'
          count = 0
        end
      end
    end
    returnString
  end
end


class CdsMap
  attr_accessor :frame, :start_codon, :end_codon, :seq_size

  def initialize( frame, start_codon, end_codon, seq_size)
    @frame = frame
    @start_codon = start_codon
    @end_codon = end_codon
    @seq_size = seq_size
  end

  def is_valid?
    !start_codon.nil?
  end


  def start_aa
    start_codon
  end

  def cds_aa_size
    return 0 if end_codon.nil?
    end_codon - start_codon - 1
  end

  def utr_5_na_size
    start_na
  end

  def utr_n_aa_size
    start_aa
  end

  def start_na
    return nil if start_codon.nil?

    if @frame == 1  || @frame == 4
      start_codon * 3
    elsif @frame == 2 || @frame == 5
      start_codon * 3 + 1
    elsif @frame == 3 || @frame == 6
      start_codon * 3 + 2
    end
  end

  def start_aa
    return nil if start_codon.nil?
    start_codon
  end

  def end_na
    return nil if start_codon.nil?

    if @frame == 1  || @frame == 4
      end_codon * 3
    elsif @frame == 2 || @frame == 5
      end_codon * 3 + 1
    elsif @frame == 3 || @frame == 6
      end_codon * 3 + 2
    end

  end

  def end_aa
    return nil if start_codon.nil?
    end_codon
  end

  def cds_na_size
    cds_aa_size * 3
  end

end
