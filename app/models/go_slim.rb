class GoSlim < ActiveRecord::Base
  attr_accessible :subset
  has_many :gene_otology_sequences


end


