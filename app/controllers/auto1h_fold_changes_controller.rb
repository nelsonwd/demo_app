class Auto1hFoldChangesController < ApplicationController
  # GET /auto1h_fold_changes
  # GET /auto1h_fold_changes.xml
  def index
    @auto1h_fold_changes = Auto1hFoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @auto1h_fold_changes }
    end
  end

  # GET /auto1h_fold_changes/1
  # GET /auto1h_fold_changes/1.xml
  def show
    @auto1h_fold_change = Auto1hFoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @auto1h_fold_change }
    end
  end

  # GET /auto1h_fold_changes/new
  # GET /auto1h_fold_changes/new.xml
  def new
    @auto1h_fold_change = Auto1hFoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @auto1h_fold_change }
    end
  end

  # GET /auto1h_fold_changes/1/edit
  def edit
    @auto1h_fold_change = Auto1hFoldChange.find(params[:id])
  end

  # POST /auto1h_fold_changes
  # POST /auto1h_fold_changes.xml
  def create
    @auto1h_fold_change = Auto1hFoldChange.new(params[:auto1h_fold_change])

    respond_to do |format|
      if @auto1h_fold_change.save
        format.html { redirect_to(@auto1h_fold_change, :notice => 'Auto1h fold change was successfully created.') }
        format.xml  { render :xml => @auto1h_fold_change, :status => :created, :location => @auto1h_fold_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @auto1h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /auto1h_fold_changes/1
  # PUT /auto1h_fold_changes/1.xml
  def update
    @auto1h_fold_change = Auto1hFoldChange.find(params[:id])

    respond_to do |format|
      if @auto1h_fold_change.update_attributes(params[:auto1h_fold_change])
        format.html { redirect_to(@auto1h_fold_change, :notice => 'Auto1h fold change was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @auto1h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /auto1h_fold_changes/1
  # DELETE /auto1h_fold_changes/1.xml
  def destroy
    @auto1h_fold_change = Auto1hFoldChange.find(params[:id])
    @auto1h_fold_change.destroy

    respond_to do |format|
      format.html { redirect_to(auto1h_fold_changes_url) }
      format.xml  { head :ok }
    end
  end
end
