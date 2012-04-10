class Hetero1hFoldChangesController < ApplicationController
  # GET /hetero1h_fold_changes
  # GET /hetero1h_fold_changes.xml
  def index
    @hetero1h_fold_changes = Hetero1hFoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hetero1h_fold_changes }
    end
  end

  # GET /hetero1h_fold_changes/1
  # GET /hetero1h_fold_changes/1.xml
  def show
    @hetero1h_fold_change = Hetero1hFoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hetero1h_fold_change }
    end
  end

  # GET /hetero1h_fold_changes/new
  # GET /hetero1h_fold_changes/new.xml
  def new
    @hetero1h_fold_change = Hetero1hFoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hetero1h_fold_change }
    end
  end

  # GET /hetero1h_fold_changes/1/edit
  def edit
    @hetero1h_fold_change = Hetero1hFoldChange.find(params[:id])
  end

  # POST /hetero1h_fold_changes
  # POST /hetero1h_fold_changes.xml
  def create
    @hetero1h_fold_change = Hetero1hFoldChange.new(params[:hetero1h_fold_change])

    respond_to do |format|
      if @hetero1h_fold_change.save
        format.html { redirect_to(@hetero1h_fold_change, :notice => 'Hetero1h fold change was successfully created.') }
        format.xml  { render :xml => @hetero1h_fold_change, :status => :created, :location => @hetero1h_fold_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hetero1h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hetero1h_fold_changes/1
  # PUT /hetero1h_fold_changes/1.xml
  def update
    @hetero1h_fold_change = Hetero1hFoldChange.find(params[:id])

    respond_to do |format|
      if @hetero1h_fold_change.update_attributes(params[:hetero1h_fold_change])
        format.html { redirect_to(@hetero1h_fold_change, :notice => 'Hetero1h fold change was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hetero1h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hetero1h_fold_changes/1
  # DELETE /hetero1h_fold_changes/1.xml
  def destroy
    @hetero1h_fold_change = Hetero1hFoldChange.find(params[:id])
    @hetero1h_fold_change.destroy

    respond_to do |format|
      format.html { redirect_to(hetero1h_fold_changes_url) }
      format.xml  { head :ok }
    end
  end
end
