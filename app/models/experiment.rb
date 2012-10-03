class Experiment < ActiveRecord::Base
  has_many :de_analyses, :dependent => :destroy
  has_many :leaders
end
