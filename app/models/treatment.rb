class Treatment < ActiveRecord::Base
  has_many :de_data
  has_many :leaders
end
