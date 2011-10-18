class CreateBlastDbs < ActiveRecord::Migration
  def self.up
    create_table :blast_dbs do |t|
      t.string :display_name
      t.string :blast_index_name
      t.string :file_name
      t.string :organism_name
      t.integer :taxonomy_id
      t.string :description
      t.string :data_type
      t.integer :num_seqs
      t.string :url
      t.string :image
      t.integer :parent

      t.timestamps
    end
  end

  def self.down
    drop_table :blast_dbs
  end
end
