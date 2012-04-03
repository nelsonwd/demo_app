class FeatureIndexFix < ActiveRecord::Migration
  def self.up
    remove_index :features, :name => 'index_features_on_sequence_id_and_annotation_id'
    add_index :features , [:sequence_id,:annotation_id,:start_pos,:end_pos], :unique => true, :name => "index_features_unique_feature"
  end

  def self.down
    remove_index :features, :name => 'index_features_unique_freature'
    add_index :features , [:sequence_id,:annotation_id], :unique => true
  end
end
