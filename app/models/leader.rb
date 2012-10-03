class Leader < ActiveRecord::Base
  attr_accessible :blast_db_id, :experiment_id, :leader_len, :leader_seq, :read_seq, :start_pos, :treatment_id
  belongs_to :blast_db
  belongs_to :experiment
  belongs_to :treatment
  has_and_belongs_to_many :sequences


  def Leader.load(file)
    file = File.open(file, 'r')
    file.each_line do |f|
      parts = f.split
      begin
        Leader.create!(:experiment_id => parts[0].to_i, :treatment_id => parts[1].to_i, :blast_db_id => parts[2].to_i,
                    :read_seq => parts[3] , :leader_seq => parts[4], :leader_len => parts[5].to_i, :start_pos => parts[6].to_i )
      rescue  ActiveRecord::RecordNotUnique => e
        puts e
      end
    end
  end
end
