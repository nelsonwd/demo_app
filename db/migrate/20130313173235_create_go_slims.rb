class CreateGoSlims < ActiveRecord::Migration
  def change
    create_table :go_slims do |t|
      t.string :subset

      t.timestamps
    end
  end
end
