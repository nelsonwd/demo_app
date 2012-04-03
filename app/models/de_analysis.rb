class DeAnalysis < ActiveRecord::Base
  belongs_to :experiment
  has_many   :de_data, :dependent => :destroy
  has_many   :fold_changes, :dependent => :destroy
end
