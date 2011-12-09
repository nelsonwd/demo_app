require_relative "blast_result"

class BlastReport

  attr_accessor :databases, :program, :version, :blast_results

  def initialize(program, version, databases)
    @program = program
    @version = version
    @databases = databases
    @blast_results = []
  end
    
  def html_report
#    report = "<div>Program: #{@program}</div>"
    report = "<div><b>#{@version}</b></div>"

    report += "<div><b>Databases:</b><ul>"
    @databases.each do |db|
      report += "<li>#{db}"
    end
    report += "</ul></div>"
    @blast_results.each do |br|
      report += br.html_report
    end
    report
  end
end
