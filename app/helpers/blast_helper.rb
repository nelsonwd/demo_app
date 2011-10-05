module BlastHelper
  def blastParse
    if @output_format == '6'
      table_string = "<table border=1 ><tr><th></th><th>qID</th><th>sID</th><th>%</th><th>lgth</th><th>err</th><th>gap</th><th>qstart</th><th>qend</th><th>sstart</th><th>send</th><th>eval</th><th>bit</th></tr>"
      file = File.new("tmp/#{@timestamp}_result.txt", "r")
      while (line = file.gets)
        table_string += "<tr><td><input type=checkbox name=subject /></td>"
        parts = line.split
        count = 0
        parts.each do |p|
          count += 1
          if count == 2
            table_string += "<td><a href=#>"
          else 
            table_string += "<td>"   
          end
          table_string += p
          if count == 2
            table_string += "</a></td>"
          else
            table_string += "</td>"
          end
        end
        table_string += "</tr>"
      end
      table_string += "</table>"

      file.close
      table_string
    else
      render :file => "tmp/#{@timestamp}_result.txt", :template => 'layouts/application'
    end
  end
end
