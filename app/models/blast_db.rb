class BlastDb < ActiveRecord::Base
  def self.run
    file = File.open("#{Rails.root}/db/blast_db.csv", 'rb')
    while(line = file.gets)
      row = line.split(",");
      BlastDb.create(:id => row[0],:display_name => row[1],:blast_index_name => row[2],:file_name => row[3],:organism_name => row[4],:taxonomy_id => row[5],:description => row[6],:data_type => row[7],:num_seqs => row[8],:url => row[9],:image => row[10],:parent => row[11],:created_at => row[12],:updated_at => row[13])
    end
  end
end
