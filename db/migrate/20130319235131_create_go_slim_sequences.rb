class CreateGoSlimSequences < ActiveRecord::Migration
  def change
    create_table :go_slim_sequences do |t|
      t.integer :sequence_id
      t.integer :gene_ontology_id
      t.integer :go_slim_id
      t.integer :go_seq_accession
      t.string  :go_seq_description
      t.string  :gene_symbol
      t.integer :taxon
      t.string  :evidence_code

      t.timestamps
    end
    add_index :go_slim_sequences, [:sequence_id, :go_slim_id]
    add_index :go_slim_sequences, [:gene_ontology_id, :go_slim_id]
    add_index :go_slim_sequences, [:gene_ontology_id, :go_slim_id, :sequence_id], :unique => true, :name => 'index_go_slim_seqs'
    add_index :go_slim_sequences, :sequence_id
    add_index :go_slim_sequences, :gene_ontology_id
  end
end
