class CreateDeAnalyses < ActiveRecord::Migration
  def self.up
    create_table :de_analyses do |t|
      t.string :method
      t.string :script_name
      t.integer :experiment_id

      t.timestamps
    end
    add_index :de_analyses, :script_name, :unique => true
  end

  def self.down
    drop_table :de_analyses
  end
end
