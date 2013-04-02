class GeneOntology < ActiveRecord::Base
  has_and_belongs_to_many :interpros
  has_many :go_slim_sequences



  def GeneOntology.load file_name
    file = File.open("#{Rails.root}/#{file_name}", 'rb')

    while(line = file.gets)
      parts = line.split("\t")
      accession = parts[0]
      ontology_root = parts[1]
      keyword = parts[2].chomp
      GeneOntology.find_or_create_by_accession(accession, :ontology_root => ontology_root, :keyword => keyword)
    end
  end

  def label
    "#{keyword} (#{accession})"
  end
end
