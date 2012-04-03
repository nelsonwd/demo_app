class DeDataController < ApplicationController
  # GET /de_data
  # GET /de_data.xml
  def index
    @de_data = DeDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @de_data }
    end
  end

  # GET /de_data/1
  # GET /de_data/1.xml
  def show
    @de_datum = DeDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @de_datum }
    end
  end

  # GET /de_data/new
  # GET /de_data/new.xml
  def new
    @de_datum = DeDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @de_datum }
    end
  end

  # GET /de_data/1/edit
  def edit
    @de_datum = DeDatum.find(params[:id])
  end

  # POST /de_data
  # POST /de_data.xml
  def create
    @de_datum = DeDatum.new(params[:de_datum])

    respond_to do |format|
      if @de_datum.save
        format.html { redirect_to(@de_datum, :notice => 'De datum was successfully created.') }
        format.xml  { render :xml => @de_datum, :status => :created, :location => @de_datum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @de_datum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /de_data/1
  # PUT /de_data/1.xml
  def update
    @de_datum = DeDatum.find(params[:id])

    respond_to do |format|
      if @de_datum.update_attributes(params[:de_datum])
        format.html { redirect_to(@de_datum, :notice => 'De datum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @de_datum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /de_data/1
  # DELETE /de_data/1.xml
  def destroy
    @de_datum = DeDatum.find(params[:id])
    @de_datum.destroy

    respond_to do |format|
      format.html { redirect_to(de_data_url) }
      format.xml  { head :ok }
    end
  end
end
