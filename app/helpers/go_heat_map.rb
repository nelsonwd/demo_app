class GoHeatMap

  attr_accessor :log2fc, :treatments, :accessions, :total_transcripts

  def initialize log2fc = [], treatments = [], accessions = [], total_transcripts = '0'
    @log2fc = log2fc
    @treatments = treatments
    @accessions = accessions
    @total_transcripts = total_transcripts
    end
end