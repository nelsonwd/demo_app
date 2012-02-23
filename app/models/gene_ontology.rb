class GeneOntology < ActiveRecord::Base
  has_and_belongs_to_many :interpros
end
