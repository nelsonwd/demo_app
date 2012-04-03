class DeDatum < ActiveRecord::Base
   belongs_to :de_analysis
   belongs_to :sequence
   belongs_to :treatment
end
