class Annotation < ActiveRecord::Base
  has_many :features, :dependent => :destroy
  belongs_to :annotation_source
  belongs_to :interpro
end
