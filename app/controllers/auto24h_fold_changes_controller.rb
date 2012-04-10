class Auto24hFoldChangesController < ApplicationController
  # GET /auto24h_fold_changes
  # GET /auto24h_fold_changes.xml
  def index
    @auto24h_fold_changes = Auto24hFoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @auto24h_fold_changes }
    end
  end

  # GET /auto24h_fold_changes/1
  # GET /auto24h_fold_changes/1.xml
  def show
    @auto24h_fold_change = Auto24hFoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @auto24h_fold_change }
    end
  end

  # GET /auto24h_fold_changes/new
  # GET /auto24h_fold_changes/new.xml
  def new
    @auto24h_fold_change = Auto24hFoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @auto24h_fold_change }
    end
  end

  # GET /auto24h_fold_changes/1/edit
  def edit
    @auto24h_fold_change = Auto24hFoldChange.find(params[:id])
  end

  # POST /auto24h_fold_changes
  # POST /auto24h_fold_changes.xml
  def create
    @auto24h_fold_change = Auto24hFoldChange.new(params[:auto24h_fold_change])

    respond_to do |format|
      if @auto24h_fold_change.save
        format.html { redirect_to(@auto24h_fold_change, :notice => 'Auto24h fold change was successfully created.') }
        format.xml  { render :xml => @auto24h_fold_change, :status => :created, :location => @auto24h_fold_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @auto24h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /auto24h_fold_changes/1
  # PUT /auto24h_fold_changes/1.xml
  def update
    @auto24h_fold_change = Auto24hFoldChange.find(params[:id])

    respond_to do |format|
      if @auto24h_fold_change.update_attributes(params[:auto24h_fold_change])
        format.html { redirect_to(@auto24h_fold_change, :notice => 'Auto24h fold change was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @auto24h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /auto24h_fold_changes/1
  # DELETE /auto24h_fold_changes/1.xml
  def destroy
    @auto24h_fold_change = Auto24hFoldChange.find(params[:id])
    @auto24h_fold_change.destroy

    respond_to do |format|
      format.html { redirect_to(auto24h_fold_changes_url) }
      format.xml  { head :ok }
    end
  end
end
