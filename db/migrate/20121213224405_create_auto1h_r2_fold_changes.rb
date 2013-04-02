class CreateAuto1hR2FoldChanges < ActiveRecord::Migration
  def change
    create_table :auto1h_r2_fold_changes do |t|
      t.float :log2fc
      t.float :fdr
      t.float :pval
      t.integer :de_analysis_id
      t.integer :treatment_id
      t.integer :base_treatment_id
      t.integer :sequence_id
      t.integer :de_datum_id

      t.timestamps
    end
    add_index :auto1h_r2_fold_changes, [:sequence_id, :de_analysis_id, :treatment_id, :base_treatment_id], :unique => true, :name => 'index_auto1h_r2_fold_changes'
    add_index :auto1h_r2_fold_changes, [:de_datum_id, :treatment_id, :de_analysis_id,:sequence_id,:base_treatment_id], :unique => true, :name => 'index_a1hr2_de_data_to_fc'
  end
end
