class BlastController < ApplicationController

  Rails.logger = Logger.new(STDOUT)

  def submit
    @timestamp = Time.now.to_i
    @task = params[:blastprogramchoice]
    @expectvalue = params[:expectvalue]
    @output_format = params[:output_format]
    @ch_genom = params[:ch_genom]
    @db_list = @ch_genom.join(" ")
    @local_filename = "#{Rails.root}/tmp/#{@timestamp}_query.fa"
    redirect_to wait_path(:timestamp => @timestamp, :loadcount => 0, :output_format => @output_format)
    File.open(@local_filename, 'w') {|f| f.write(params[:in_querysequence]) }
    if @task == 'blastn'
      @blast_cmd = "blastn -query #{Rails.root}/tmp/#{@timestamp}_query.fa -db \\\"#{@db_list}\\\" -task blastn -evalue #{@expectvalue} -num_alignments 20 -num_descriptions 20 -html -outfmt #{@output_format} -out #{Rails.root}/tmp/#{@timestamp}_working.txt 2>#{Rails.root}/tmp/#{@timestamp}_error.txt"
    elsif @task == 'tblastn'
      @blast_cmd = "tblastn -query #{Rails.root}/tmp/#{@timestamp}_query.fa -db \\\"#{@db_list}\\\" -evalue #{@expectvalue} -num_alignments 20 -num_descriptions 20 -html -outfmt #{@output_format} -out #{Rails.root}/tmp/#{@timestamp}_working.txt 2>#{Rails.root}/tmp/#{@timestamp}_error.txt"
    elsif @task == 'tblastx'
      @blast_cmd = "tblastx -query #{Rails.root}/tmp/#{@timestamp}_query.fa -db \\\"#{@db_list}\\\" -evalue #{@expectvalue} -num_alignments 20 -num_descriptions 20 -html -outfmt #{@output_format} -out #{Rails.root}/tmp/#{@timestamp}_working.txt 2>#{Rails.root}/tmp/#{@timestamp}_error.txt"
    end
    scriptCmd =  "#{Rails.root}/lib/tasks/blast.rb \"#{@blast_cmd}\" #{Rails.root}/tmp/#{@timestamp} &"
    logger.debug scriptCmd
    system(scriptCmd);
  end

  def wait
    @loadcount = params[:loadcount].to_i + 1
    @timestamp = params[:timestamp]
    @output_format = params[:output_format]
    if FileTest.exist?("#{Rails.root}/tmp/#{@timestamp}_result.txt")
      redirect_to result_path(:timestamp => @timestamp, :output_format => @output_format)	
    elsif(FileTest.size?("#{Rails.root}/tmp/#{@timestamp}_error.txt"))
      redirect_to result_path(:timestamp => @timestamp, :output_format => "error")	
    end
  end

  def result
    @timestamp = params[:timestamp]
    @output_format = params[:output_format]
    #@mystring = 'The file did not load?'
    #File.open("tmp/#{@timestamp}_result.txt", "r") { |f|
    #@mystring = f.read
    #render :file => "tmp/#{@timestamp}_result.txt", :template => 'layouts/application'
  end

end
