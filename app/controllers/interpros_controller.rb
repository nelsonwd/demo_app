class InterprosController < ApplicationController
  # GET /interpros
  # GET /interpros.xml
  def index
    @interpros = Interpro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interpros }
    end
  end

  # GET /interpros/1
  # GET /interpros/1.xml
  def show
    @interpro = Interpro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interpro }
    end
  end

  # GET /interpros/new
  # GET /interpros/new.xml
  def new
    @interpro = Interpro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interpro }
    end
  end

  # GET /interpros/1/edit
  def edit
    @interpro = Interpro.find(params[:id])
  end

  # POST /interpros
  # POST /interpros.xml
  def create
    @interpro = Interpro.new(params[:interpro])

    respond_to do |format|
      if @interpro.save
        format.html { redirect_to(@interpro, :notice => 'Interpro was successfully created.') }
        format.xml  { render :xml => @interpro, :status => :created, :location => @interpro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interpro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interpros/1
  # PUT /interpros/1.xml
  def update
    @interpro = Interpro.find(params[:id])

    respond_to do |format|
      if @interpro.update_attributes(params[:interpro])
        format.html { redirect_to(@interpro, :notice => 'Interpro was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interpro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interpros/1
  # DELETE /interpros/1.xml
  def destroy
    @interpro = Interpro.find(params[:id])
    @interpro.destroy

    respond_to do |format|
      format.html { redirect_to(interpros_url) }
      format.xml  { head :ok }
    end
  end
end
