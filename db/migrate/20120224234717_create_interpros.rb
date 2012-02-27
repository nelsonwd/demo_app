class CreateInterpros < ActiveRecord::Migration
  def self.up
    create_table :interpros do |t|
      t.string :accession
      t.string :desc

      t.timestamps
    end
  end

  def self.down
    drop_table :interpros
  end
end
