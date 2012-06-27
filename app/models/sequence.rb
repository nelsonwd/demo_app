class Sequence < ActiveRecord::Base
  belongs_to :blast_db
  has_many :features,  :dependent => :destroy
  has_many :de_data,  :dependent => :destroy
  has_many :annotations, :through => :features

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

end

class CdsMapper

  def initialize(sequence)
    @na_seq = Bio::Sequence::NA.new(sequence.na_seq)
    @sequence = sequence
    @maps = []
    map_cds
  end

  def map_cds
    1.upto(6).each do |i|  #frame loop
      aa_sequence = @na_seq.translate(i)
      start_codon = nil
      end_codon = nil
      if start_codon = aa_sequence.index(?M)
        if end_codon = aa_sequence.index(?*, start_codon + 1)
          start_codon = end_codon = nil if (end_codon - start_codon) == 1
        else
          start_codon = nil
        end
      end
      @maps[i - 1] = CdsMap.new i, start_codon, end_codon, @na_seq.size
    end
  end

  def protein_to_s frame
    map = @maps[frame - 1]
    prot_seq = @na_seq.translate frame
    if map.is_valid?
      puts prot_seq[0, map.start_codon ]
      puts prot_seq[map.start_codon]
      puts prot_seq[map.start_codon + 1,(map.end_codon - map.start_codon - 1)]
      puts prot_seq[map.end_codon]
      puts prot_seq[map.end_codon + 1, prot_seq.size]
    else
      puts "#{map.frame}, #{map.start_codon}, #{map.end_codon}"
    end
  end

  def aa_to_s frame
    @na_seq.translate(frame)
  end

  def na_to_s  frame
    if frame.to_i < 4
      @na_seq.to_s.upcase
    else
      @na_seq.complement.to_s.upcase
    end
  end

  def na_to_html frame
    return wrap(na_to_s(frame),80)  unless is_valid? frame

    na = "<span style=\"color:green\" >#{utr_5_na frame}</span>"
    na += "<span style=\"color:red\" >#{start_na(frame)}</span>"
    na += "<span style=\"color:blue\" >#{cds_na(frame)}</span>"
    na += "<span style=\"color:red\" >#{stop_na(frame)}</span>"
    na += "<span style=\"color:green\" >#{utr_3_na(frame)}</span>"
    wrap na, 80
  end

  def start_aa frame
    @maps[frame - 1].start_na
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


  def utr_5_na frame
    return '' unless is_valid? frame
    na_to_s(frame)[0, utr_5_na_size(frame) ]

  end

  def utr_5_na_size frame
    @maps[frame.to_i - 1].utr_5_na_size
  end

  def utr_3_na frame
    return '' unless is_valid? frame
    map = @maps[frame.to_i - 1]
    utr_start = map.end_na + 3
    seq = na_to_s(frame)
    seq[utr_start, seq.size - utr_start]
  end

  def cds_na  frame
    return '' unless  is_valid? frame
    map =  @maps[frame.to_i - 1]
    cds_na_start = map.start_na + 3
    na_to_s(frame)[cds_na_start,map.cds_na_size]
  end

  def is_valid? frame
    @maps[frame.to_i - 1].is_valid?
  end

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

  def cds_na_size
    cds_aa_size * 3
  end

end
