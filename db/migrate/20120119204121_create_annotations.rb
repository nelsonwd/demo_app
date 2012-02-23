class CreateAnnotations < ActiveRecord::Migration
  def self.up
    create_table :annotations do |t|
      t.string :accession
      t.string :desc
      t.integer :annotation_source_id
      t.integer :interpro_id

      t.timestamps
    end
    add_index :annotations, :accession, :unique => true
  end

  def self.down
    drop_table :annotations
  end
end
