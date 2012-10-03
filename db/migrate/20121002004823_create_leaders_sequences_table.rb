class CreateLeadersSequencesTable < ActiveRecord::Migration
  def self.up
    create_table :leaders_sequences, :id => false do |t|
      t.references :leader
      t.references :sequence
    end
    add_index :leaders_sequences , :leader_id
    add_index :leaders_sequences , :sequence_id
    add_index :leaders_sequences , [:leader_id,:sequence_id], :unique => true, :name => "index_leader_on_sequence"
  end

  def self.down
    drop_table :leaders_sequences
  end
end
