class DeAnalysesController < ApplicationController
  # GET /de_analyses
  # GET /de_analyses.xml
  def index
    @de_analyses = DeAnalysis.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @de_analyses }
    end
  end

  # GET /de_analyses/1
  # GET /de_analyses/1.xml
  def show
    @de_analysis = DeAnalysis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @de_analysis }
    end
  end

  # GET /de_analyses/new
  # GET /de_analyses/new.xml
  def new
    @de_analysis = DeAnalysis.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @de_analysis }
    end
  end

  # GET /de_analyses/1/edit
  def edit
    @de_analysis = DeAnalysis.find(params[:id])
  end

  # POST /de_analyses
  # POST /de_analyses.xml
  def create
    @de_analysis = DeAnalysis.new(params[:de_analysis])

    respond_to do |format|
      if @de_analysis.save
        format.html { redirect_to(@de_analysis, :notice => 'De analysis was successfully created.') }
        format.xml  { render :xml => @de_analysis, :status => :created, :location => @de_analysis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @de_analysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /de_analyses/1
  # PUT /de_analyses/1.xml
  def update
    @de_analysis = DeAnalysis.find(params[:id])

    respond_to do |format|
      if @de_analysis.update_attributes(params[:de_analysis])
        format.html { redirect_to(@de_analysis, :notice => 'De analysis was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @de_analysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /de_analyses/1
  # DELETE /de_analyses/1.xml
  def destroy
    @de_analysis = DeAnalysis.find(params[:id])
    @de_analysis.destroy

    respond_to do |format|
      format.html { redirect_to(de_analyses_url) }
      format.xml  { head :ok }
    end
  end
end
