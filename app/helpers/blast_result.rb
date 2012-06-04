require_relative "blast_hit"

class BlastResult
  
  attr_accessor :query_num, :query_def, :query_len, :blast_hits
  
  def initialize(query_num, query_def, query_len)
    @query_num = query_num
    @query_def = query_def
    @query_len = query_len
    @blast_hits = []
  end

  def html_report
    #report = "<div>Query Number: #{query_num}</div>"
    report = "<div><b>Query=</b> #{query_def}</div>\n"
    report += "<div>Length=#{query_len}</div>"
    report += "\n" + ' '*70 + "Score" + ' '*5 + "E\n"
    report += "Sequences producing significant alignments:" + ' '*26 + "(Bits)  Value\n\n"
    report += "<img src=\"/assets/blastLegend.gif\" /><br>"
    @blast_hits.each do |bh|
      report += bh.html_report(@query_len)
    end
    report += "\n"
    @blast_hits.each do |bh|
      report += bh.html_report_detail
    end
    report
  end
end
