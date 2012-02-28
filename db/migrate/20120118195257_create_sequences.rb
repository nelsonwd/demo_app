class CreateSequences < ActiveRecord::Migration
  def self.up
    create_table :sequences do |t|
      t.string :accession
      t.string :name
      t.string :description
      t.text :na_seq
      t.integer :blast_db_id

      t.timestamps
    end
    add_index :sequences, [:accession, :blast_db_id], :unique => true
    add_index :sequences, :accession
    add_index :sequences, :name
  end

  def self.down
    drop_table :sequences
  end
end
