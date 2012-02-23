class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.integer :sequence_id
      t.integer :annotation_id
      t.integer :start_pos
      t.integer :end_pos
      t.integer :frame
      t.float   :score
      t.string  :match_status
      t.timestamps
    end
    add_index :features , :sequence_id
    add_index :features , :annotation_id
    add_index :features , [:sequence_id,:annotation_id], :unique => true
  end

  def self.down
    drop_table :features
  end
end
