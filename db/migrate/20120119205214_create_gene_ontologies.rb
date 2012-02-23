class CreateGeneOntologies < ActiveRecord::Migration
  def self.up
    create_table :gene_ontologies do |t|
      t.string :accession
      t.string :ontology_root
      t.string :keyword

      t.timestamps
    end
    add_index :gene_ontologies, :accession, :unique => true
  end

  def self.down
    drop_table :gene_ontologies
  end
end
