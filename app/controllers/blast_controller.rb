class BlastController < ApplicationController

  Rails.logger = Logger.new(STDOUT)

  def submit
    @timestamp = Time.now.to_i
    @task = params[:blastprogramchoice]
    @expectvalue = params[:expectvalue]
# outfmt 5 is blast xml format
    @output_format = 5
    #@output_format = params[:output_format]
    @ch_genom = params[:ch_genom]
    @max_hits = params[:max_hits]
    @ch_genom.map! {|db|"/blastdbs/" + db}
    @db_list = @ch_genom.join(" ")
    @upload_io = params[:query_file]
    @local_filename = "#{Rails.root}/tmp/#{@timestamp}_query.fa"
    @options = ""  

    redirect_to wait_path(:timestamp => @timestamp, :loadcount => 0, :output_format => @output_format)
    if @upload_io == nil
      File.open(@local_filename, 'w') {|f| f.write(params[:in_querysequence]) }
    else
      File.open(@local_filename, 'w') {|f| f.write(@upload_io.read)}
    end
    if @task == 'blastn'
      @program = "blastn"
      @options = "-task blastn" 
    elsif @task == 'tblastn'
      @program = "tblastn"
    elsif @task == 'tblastx'
      @program = "tblastx"
    end
    @blast_cmd = "#{@program} -query #{Rails.root}/tmp/#{@timestamp}_query.fa -db \\\"#{@db_list}\\\" #{@options} -evalue #{@expectvalue} -num_alignments #{@max_hits} -num_descriptions #{@max_hits} -html -outfmt #{@output_format} -out #{Rails.root}/tmp/#{@timestamp}_working.txt 2>#{Rails.root}/tmp/#{@timestamp}_error.txt"
    scriptCmd =  "#{Rails.root}/lib/tasks/blast.rb \"#{@blast_cmd}\" #{Rails.root}/tmp/#{@timestamp} &"
    logger.debug scriptCmd
    system(scriptCmd);
  end

  def wait
    @loadcount = params[:loadcount].to_i + 1
    @timestamp = params[:timestamp]
    @output_format = params[:output_format]
    if FileTest.size?("#{Rails.root}/tmp/#{@timestamp}_result.txt")
      redirect_to result_path(:timestamp => @timestamp, :output_format => @output_format)	
    elsif(FileTest.size?("#{Rails.root}/tmp/#{@timestamp}_error.txt"))
      redirect_to result_path(:timestamp => @timestamp, :output_format => "error")	
    end
  end

  def result
    @title = "Blast Results"
    @timestamp = params[:timestamp]
    @output_format = params[:output_format]
    #@mystring = 'The file did not load?'
    #File.open("tmp/#{@timestamp}_result.txt", "r") { |f|
    #@mystring = f.read
    #render :file => "tmp/#{@timestamp}_result.txt", :template => 'layouts/application'
  end

end
