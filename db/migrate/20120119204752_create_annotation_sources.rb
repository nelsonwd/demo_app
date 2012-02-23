class CreateAnnotationSources < ActiveRecord::Migration
  def self.up
    create_table :annotation_sources do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :annotation_sources
  end
end
