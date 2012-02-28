class Sequence < ActiveRecord::Base
  belongs_to :blast_db
  has_many :features,  :dependent => :destroy
  has_many :annotations, :through => :features

  def Sequence.parse_accession(desc, blast_index)
    parts = desc.split("_")
    versions = parts[3].split("/")
    accession = blast_index + '_' + parts[1] 
    description = "Transcript #{versions[0]} of #{versions[1]}; Confidence #{parts[5]}; Length #{parts[7]}"
    [accession, description]
  end

  #def Sequence.parse_accession(desc, blast_index)
    #parts = desc.split(" ")
    #[parts[0], parts[1,parts.size() - 1].join(" ")]
  #end

  def Sequence.run(fasta_file, blast_index)
    file = Bio::FlatFile.open(Bio::FastaFormat, "#{Rails.root}/public/fasta/#{fasta_file}")
    db_id = BlastDb.where(:blast_index_name => blast_index).first
    file.each_entry do |f|
      accession, description = Sequence.parse_accession(f.definition, blast_index)
      Sequence.find_or_create_by_accession(accession, :name => nil, :description => description, :na_seq => f.naseq.upcase , :blast_db_id => db_id.id )
     end
  end
end
