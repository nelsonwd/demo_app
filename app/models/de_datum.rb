class DeDatum < ActiveRecord::Base
   belongs_to :de_analysis
   belongs_to :sequence
   belongs_to :treatment
# The input file should contain rows of the symbol followed by an RPKM for each treatment
# The treatment argument is an array with the treatment IDs in the same order as the RPKM columns

def DeDatum.load filename, de_analysis_id, treatments
  file = File.open("#{Rails.root}/#{filename}", 'rb')
  while(line = file.gets)
    col_count = 1
    parts = line.split
    next if parts[0] == "Symbol"
    seq_name = parts[0]
    seq = Sequence.where(:accession => seq_name ).first
    treatments.each do |t|
      rpkm = parts[col_count]
      DeDatum.create(:sequence_id => seq.id, :de_analysis_id => de_analysis_id, :treatment_id => t, :abundance => rpkm)  
      col_count += 1
    end
  end
end
end
