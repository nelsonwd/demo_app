class CreateFoldChanges < ActiveRecord::Migration
  def self.up
    create_table :fold_changes do |t|
      t.float :log2fc
      t.float :fdr
      t.float :pval
      t.integer :de_analysis_id
      t.integer :treatment_id
      t.integer :base_treatment_id
      t.integer :sequence_id

      t.timestamps
    end
    add_index :fold_changes, [:sequence_id, :treatment_id, :base_treatment_id], :unique => true, :name => 'index_fold_changes'
  end

  def self.down
    drop_table :fold_changes
  end
end
