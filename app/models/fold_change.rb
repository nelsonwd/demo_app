class FoldChange < ActiveRecord::Base
  belongs_to :de_analysis
  belongs_to :sequence
  belongs_to :treatment
  belongs_to :base_treatment, :class_name => "Treatment", :foreign_key => "base_treatment_id"
end
