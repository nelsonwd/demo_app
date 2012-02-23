class CreateGeneOntologiesInterprosTable < ActiveRecord::Migration
  def self.up
    create_table :gene_ontologies_interpros, :id => false do |t|
      t.references :interpro
      t.references :gene_ontology
    end
    add_index :gene_ontologies_interpros , :interpro_id
    add_index :gene_ontologies_interpros, :gene_ontology_id
    add_index :gene_ontologies_interpros , [:interpro_id,:gene_ontology_id], :name => 'index_gene_ontologies_interpros_on_interpro_id_gene_ontology_id', :unique => true
  end

  def self.down
    drop_table :gene_ontologies_interpros
  end
end
