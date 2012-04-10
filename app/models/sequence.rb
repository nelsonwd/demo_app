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

  def frame_translate frame_number
    seq = Bio::Sequence::NA.new(self.na_seq)
    seq.translate frame_number
  end

  def frame_translate_html frame_number
    aa = frame_translate frame_number
    if m_idx = aa.index('M') then
      if stop_idx = aa.index('*',m_idx) then
        aa = aa.insert(stop_idx + 1, "</span>")
        aa  = aa.insert(m_idx,"<span style='color:red;' >")
        
      end
    end
  end
end
