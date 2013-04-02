class GoHeatMap

  attr_accessor :log2fc, :treatments, :accessions

  def initialize log2fc = [], treatments = [], accessions = []
    @log2fc = log2fc
    @treatments = treatments
    @accessions = accessions
    end
end