class Hetero24hFoldChangesController < ApplicationController
  # GET /hetero24h_fold_changes
  # GET /hetero24h_fold_changes.xml
  def index
    @hetero24h_fold_changes = Hetero24hFoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hetero24h_fold_changes }
    end
  end

  # GET /hetero24h_fold_changes/1
  # GET /hetero24h_fold_changes/1.xml
  def show
    @hetero24h_fold_change = Hetero24hFoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hetero24h_fold_change }
    end
  end

  # GET /hetero24h_fold_changes/new
  # GET /hetero24h_fold_changes/new.xml
  def new
    @hetero24h_fold_change = Hetero24hFoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hetero24h_fold_change }
    end
  end

  # GET /hetero24h_fold_changes/1/edit
  def edit
    @hetero24h_fold_change = Hetero24hFoldChange.find(params[:id])
  end

  # POST /hetero24h_fold_changes
  # POST /hetero24h_fold_changes.xml
  def create
    @hetero24h_fold_change = Hetero24hFoldChange.new(params[:hetero24h_fold_change])

    respond_to do |format|
      if @hetero24h_fold_change.save
        format.html { redirect_to(@hetero24h_fold_change, :notice => 'Hetero24h fold change was successfully created.') }
        format.xml  { render :xml => @hetero24h_fold_change, :status => :created, :location => @hetero24h_fold_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hetero24h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hetero24h_fold_changes/1
  # PUT /hetero24h_fold_changes/1.xml
  def update
    @hetero24h_fold_change = Hetero24hFoldChange.find(params[:id])

    respond_to do |format|
      if @hetero24h_fold_change.update_attributes(params[:hetero24h_fold_change])
        format.html { redirect_to(@hetero24h_fold_change, :notice => 'Hetero24h fold change was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hetero24h_fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hetero24h_fold_changes/1
  # DELETE /hetero24h_fold_changes/1.xml
  def destroy
    @hetero24h_fold_change = Hetero24hFoldChange.find(params[:id])
    @hetero24h_fold_change.destroy

    respond_to do |format|
      format.html { redirect_to(hetero24h_fold_changes_url) }
      format.xml  { head :ok }
    end
  end
end
