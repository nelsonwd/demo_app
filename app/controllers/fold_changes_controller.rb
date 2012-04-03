class FoldChangesController < ApplicationController
  # GET /fold_changes
  # GET /fold_changes.xml
  def index
    @fold_changes = FoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fold_changes }
    end
  end

  # GET /fold_changes/1
  # GET /fold_changes/1.xml
  def show
    @fold_change = FoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fold_change }
    end
  end

  # GET /fold_changes/new
  # GET /fold_changes/new.xml
  def new
    @fold_change = FoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fold_change }
    end
  end

  # GET /fold_changes/1/edit
  def edit
    @fold_change = FoldChange.find(params[:id])
  end

  # POST /fold_changes
  # POST /fold_changes.xml
  def create
    @fold_change = FoldChange.new(params[:fold_change])

    respond_to do |format|
      if @fold_change.save
        format.html { redirect_to(@fold_change, :notice => 'Fold change was successfully created.') }
        format.xml  { render :xml => @fold_change, :status => :created, :location => @fold_change }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fold_changes/1
  # PUT /fold_changes/1.xml
  def update
    @fold_change = FoldChange.find(params[:id])

    respond_to do |format|
      if @fold_change.update_attributes(params[:fold_change])
        format.html { redirect_to(@fold_change, :notice => 'Fold change was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fold_change.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fold_changes/1
  # DELETE /fold_changes/1.xml
  def destroy
    @fold_change = FoldChange.find(params[:id])
    @fold_change.destroy

    respond_to do |format|
      format.html { redirect_to(fold_changes_url) }
      format.xml  { head :ok }
    end
  end
end
