class CreateExperiments < ActiveRecord::Migration
  def self.up
    create_table :experiments do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :experiments, :name , :unique => true
  end

  def self.down
    drop_table :experiments
  end
end