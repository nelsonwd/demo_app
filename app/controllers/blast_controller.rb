class BlastController < ApplicationController

  Rails.logger = Logger.new(STDOUT)

  def submit
    @timestamp = Time.now.to_i
    @expectvalue = params[:expectvalue]
    @output_format = params[:output_format]
    @ch_genom = params[:ch_genom]
    @local_filename = "tmp/#{@timestamp}_query.fa"
    redirect_to wait_path(:timestamp => @timestamp, :loadcount => 0, :output_format => @output_format)
    File.open(@local_filename, 'w') {|f| f.write(params[:in_querysequence]) }
    scriptCmd =  "lib/tasks/blast.rb #{@timestamp} #{@expectvalue} #{@output_format} \"#{@ch_genom.join(" ")}\"&"
    logger.fatal scriptCmd
    system(scriptCmd);
  end

  def wait
    logger.fatal params[:loadcount]
    @loadcount = params[:loadcount].to_i + 1
    logger.fatal @loadcount
    @timestamp = params[:timestamp]
    @output_format = params[:output_format]
    logger.fatal "tmp/#{@timestamp}_result.txt"
    if FileTest.exist?("tmp/#{@timestamp}_result.txt")
      puts("tmp/#{@timestamp}_result.txt")
      redirect_to result_path(:timestamp => @timestamp, :output_format => @output_format)	
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