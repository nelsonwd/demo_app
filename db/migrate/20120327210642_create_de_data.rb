class CreateDeData < ActiveRecord::Migration
  def self.up
    create_table :de_data do |t|
      t.float :abundance
      t.integer :sequence_id
      t.integer :de_analysis_id
      t.integer :treatment_id

      t.timestamps
    end
    add_index :de_data, [:sequence_id, :treatment_id, :de_analysis_id], :unique => true, :name => 'index_de_data'
  end

  def self.down
    drop_table :de_data
  end
end
