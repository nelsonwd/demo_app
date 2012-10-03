class CreateLeaders < ActiveRecord::Migration
  def self.up
    create_table :leaders do |t|
      t.integer :experiment_id
      t.integer :treatment_id
      t.integer :blast_db_id
      t.string :read_seq
      t.string :leader_seq
      t.integer :leader_len
      t.integer :start_pos

      t.timestamps
    end
    add_index :leaders, [:experiment_id, :blast_db_id,:treatment_id,:read_seq ], :unique => true, :name => "index_experiment_id_treatment_id_blast_db_id_read"
  end

  def self.down
    drop_table :leaders
  end
end
