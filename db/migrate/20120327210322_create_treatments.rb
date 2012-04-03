class CreateTreatments < ActiveRecord::Migration
  def self.up
    create_table :treatments do |t|
      t.string :name
      t.string :description
      t.integer :ordering

      t.timestamps
    end
    add_index :treatments, :name
  end

  def self.down
    drop_table :treatments
  end
end
