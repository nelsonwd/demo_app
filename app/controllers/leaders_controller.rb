
class LeadersController < ApplicationController
  # GET /leaders
  # GET /leaders.json
  def index
    @exp_name = Experiment.find(params[:experiment].to_i).name
    @results = {}
    treatment_ids = Leader.select(:treatment_id).uniq.where(:experiment_id => 2).order(:treatment_id).map{|x| x.treatment_id }
    treatment_ids.each do |t|
      treatment_name = Treatment.find(t).name

      @results[treatment_name] = {}
      @results[treatment_name][:All] = []
      @results[treatment_name][:All][0] = 'n/a'
      @results[treatment_name][:All][1] = Leader.where("experiment_id = #{params[:experiment]} and treatment_id = #{t} and start_pos = 0").size.to_s
      @results[treatment_name][:All][2] = Leader.where("experiment_id = #{params[:experiment]} and  treatment_id = #{t} and start_pos > 0").size.to_s
      @results[treatment_name][:All][3] = Leader.where(:experiment_id => params[:experiment], :treatment_id => t).size.to_s
      @results[treatment_name][:All][4] = params[:experiment]
      @results[treatment_name][:All][5] =  t.to_s

      leaders = Leader.select(:leader_seq).uniq.where(:experiment_id => params[:experiment]).order('leader_len DESC').map{|x| x.leader_seq}
      leaders.each do |l|
        @results[treatment_name][l] = []
        @results[treatment_name][l][0] = l.size.to_s
        @results[treatment_name][l][1] = Leader.where("experiment_id = #{params[:experiment]} and  treatment_id = #{t} and start_pos = 0 and leader_seq = \'#{l}\'").size.to_s
        @results[treatment_name][l][2] = Leader.where("experiment_id = #{params[:experiment]} and  treatment_id = #{t} and start_pos > 0 and leader_seq = \'#{l}\'").size.to_s
        @results[treatment_name][l][3] = Leader.where(:experiment_id => params[:experiment].to_i, :treatment_id => t, :leader_seq => l).size.to_s
        @results[treatment_name][l][4] = params[:experiment]
        @results[treatment_name][l][5] =  t.to_s
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leaders }
    end
  end

  # GET /leaders/detail
  # GET /leaders/detail.json
  def detail
    start_sql = ""
    start_pos = params[:start_pos].to_i
    if start_pos == 0
      start_sql = " and start_pos = 0"
    elsif start_pos > 0
      start_sql = " and start_pos > 0"
    end

    leader_len_sql = ""
    if params[:leader_len] != 'n/a'
      leader_len_sql = " and leader_len = #{params[:leader_len]}"
    end

    leader_seq_sql = ''
    if params[:leader_seq] != 'All'
      leader_seq_sql = " and leader_seq = '#{params[:leader_seq]}'"
    end

    @leaders = Leader.where("experiment_id = #{params[:experiment_id]} and treatment_id = #{params[:treatment_id]} #{leader_len_sql} #{start_sql} #{leader_seq_sql}").order(:leader_len,:leader_seq)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leader }
    end
  end

  # GET /leaders/1
  # GET /leaders/1.json
  def show
    @leader = Leader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leader }
    end
  end

  # GET /leaders/new
  # GET /leaders/new.json
  def new
    @leader = Leader.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @leader }
    end
  end

  # GET /leaders/1/edit
  def edit
    @leader = Leader.find(params[:id])
  end

  # POST /leaders
  # POST /leaders.json
  def create
    @leader = Leader.new(params[:leader])

    respond_to do |format|
      if @leader.save
        format.html { redirect_to @leader, notice: 'Leader was successfully created.' }
        format.json { render json: @leader, status: :created, location: @leader }
      else
        format.html { render action: "new" }
        format.json { render json: @leader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leaders/1
  # PUT /leaders/1.json
  def update
    @leader = Leader.find(params[:id])

    respond_to do |format|
      if @leader.update_attributes(params[:leader])
        format.html { redirect_to @leader, notice: 'Leader was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @leader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaders/1
  # DELETE /leaders/1.json
  def destroy
    @leader = Leader.find(params[:id])
    @leader.destroy

    respond_to do |format|
      format.html { redirect_to leaders_url }
      format.json { head :no_content }
    end
  end
end
