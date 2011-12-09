require "rexml/document"
require_relative "blast_report_parser"

include REXML

module BlastHelper
  def blastParse
    report_parser = BlastReportParser.new("#{Rails.root}/tmp/#{@timestamp}_result.txt")
    report_string = report_parser.html_report
    
    #if @output_format == '6'
      #table_string = "<table border=1 ><tr><th></th><th title=\"The query sequence ID\">qId</th><th title=\"The subject sequence Id\" >sID</th><th title=\"Percentage of identical matches\" >%</th><th title=\"Alignment length\" >lgth</th><th title=\"Number of mismatches\" >err</th><th title=\"Number of gap openings\" >gap</th><th title=\"Start of alignment in query\" >qstart</th><th title=\"End of alignment in query\" >qend</th><th title=\"Start of alignment in subject\" >sstart</th><th title=\"End of alignment in subject\" >send</th><th title=\"Expect value\" >eval</th><th title=\"Bit score\" >bit</th></tr>"
      #file = File.new("#{Rails.root}/tmp/#{@timestamp}_result.txt", "r")
      #while (line = file.gets)
        #table_string += "<tr><td><input type=checkbox name=subject /></td>"
        #parts = line.split
        #count = 0
        #parts.each do |p|
          #count += 1
          #if count == 2
            #gi = ""
            #href = ""
            #if p.start_with?("gi")
              #gi = p.split("|")[1]
              #href = "http://www.ncbi.nlm.nih.gov/nuccore/#{gi}"
            #end
            #table_string += "<td><a href=#{href} target=\"_blank\" >"
          #else 
            #table_string += "<td>"   
          #end
          #table_string += p
          #if count == 2
            #table_string += "</a></td>"
          #else
            #table_string += "</td>"
          #end
        #end
        #table_string += "</tr>"
      #end
      #table_string += "</table>"

      #file.close
      #table_string
    #elsif @output_format == "error"
      #render :file => "#{Rails.root}/tmp/#{@timestamp}_error.txt", :template => 'layouts/application'
    #else
      #render :file => "#{Rails.root}/tmp/#{@timestamp}_result.txt", :template => 'layouts/application'
    #end
  end
end
