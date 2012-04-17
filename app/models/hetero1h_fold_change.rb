class Hetero1hFoldChange < ActiveRecord::Base
  belongs_to :de_analysis
  belongs_to :sequence
  belongs_to :treatment
  belongs_to :base_treatment, :class_name => "Treatment", :foreign_key => "base_treatment_id"
  belongs_to :de_datum

def self.load filename, de_analysis_id, treatment_id, base_treatment_id
#1 - symbol
#5 - fold change
#6 - log2 fold change
#7 - pval
#8 - fdr

  file = File.open("#{Rails.root}/#{filename}", 'rb')
  while(line = file.gets)
    parts = line.split
    next if parts[0] == "\"id\""
    seq_name = parts[1][1..(parts[1].size - 2)] 
    de_data = Sequence.where(:accession => seq_name ).first.de_data
    de_datum = de_data.select{|d| d if (d.de_analysis_id == de_analysis_id  && d.treatment_id == treatment_id)}.first
    self.create(:log2fc => parts[6], :fdr => parts[8], :pval => parts[7], :de_analysis_id => de_analysis_id, :treatment_id => treatment_id, :base_treatment_id => base_treatment_id, :sequence_id => de_datum.sequence_id, :de_datum_id => de_datum.id) 
  end
end

end
