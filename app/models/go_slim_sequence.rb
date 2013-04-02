class GoSlimSequence < ActiveRecord::Base
  attr_accessible :evidence_code, :gene_ontology_id, :gene_symbol, :go_seq_description, :go_slim_id, :sequence_id, :taxon

  belongs_to :go_slim
  belongs_to :sequence
  belongs_to :gene_ontology

  def GoSlimSequence.load file_name
    file = File.open("#{Rails.root}/#{file_name}", 'rb')

    while(line = file.gets)
      parts = line.split("\t")
      if(parts[0] =~ /^s\d_\d+$/)
        next
      end
      go_accession  = parts[4]
      go = GeneOntology.find_by_accession go_accession
      seq_accession =  parts[16].chomp
      seq = Sequence.where( :accession => seq_accession ).first
      taxon = parts[12].split(?:)[1]
      begin
        GoSlimSequence.create(:sequence_id => seq.id, :gene_ontology_id => go.id, :go_slim_id => 1,
                              :evidence_code => parts[6], :gene_symbol => parts[2], :go_seq_description => parts[9], :taxon => taxon)
      rescue ActiveRecord::RecordNotUnique
        #do nil
      end
    end
  end
end
