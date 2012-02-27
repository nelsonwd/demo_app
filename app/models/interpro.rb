class Interpro < ActiveRecord::Base
has_and_belongs_to_many :gene_ontologies
end
