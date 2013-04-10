class DeAnalysis < ActiveRecord::Base
  belongs_to :experiment
  has_many   :de_data, :dependent => :destroy
  has_many   :fold_changes, :dependent => :destroy

  def has_go_slim?
    script_name =~ /s6.R$/

    #count = DeAnalysis.find_by_sql("select *
    #                     from de_data dd,
    #                          sequences s,
    #                          go_slim_sequences gs
    #                    where #{id} = dd.de_analysis_id and
    #                          dd.sequence_id = s.id and
    #                          s.id = gs.sequence_id
    #                          limit 1").size
    #count > 0
  end
end
