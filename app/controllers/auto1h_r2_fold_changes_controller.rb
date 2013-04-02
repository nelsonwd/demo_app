
class Auto1hR2FoldChangesController < ApplicationController
  # GET /auto1h_r2_fold_changes
  # GET /auto1h_r2_fold_changes.json
  def index
    @auto1h_r2_fold_changes = Auto1hR2FoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auto1h_r2_fold_changes }
    end
  end

  # GET /auto1h_r2_fold_changes/1
  # GET /auto1h_r2_fold_changes/1.json
  def show
    @auto1h_r2_fold_change = Auto1hR2FoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @auto1h_r2_fold_change }
    end
  end

  # GET /auto1h_r2_fold_changes/new
  # GET /auto1h_r2_fold_changes/new.json
  def new
    @auto1h_r2_fold_change = Auto1hR2FoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auto1h_r2_fold_change }
    end
  end

  # GET /auto1h_r2_fold_changes/1/edit
  def edit
    @auto1h_r2_fold_change = Auto1hR2FoldChange.find(params[:id])
  end

  # POST /auto1h_r2_fold_changes
  # POST /auto1h_r2_fold_changes.json
  def create
    @auto1h_r2_fold_change = Auto1hR2FoldChange.new(params[:auto1h_r2_fold_change])

    respond_to do |format|
      if @auto1h_r2_fold_change.save
        format.html { redirect_to @auto1h_r2_fold_change, notice: 'Auto1h r2 fold change was successfully created.' }
        format.json { render json: @auto1h_r2_fold_change, status: :created, location: @auto1h_r2_fold_change }
      else
        format.html { render action: "new" }
        format.json { render json: @auto1h_r2_fold_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /auto1h_r2_fold_changes/1
  # PUT /auto1h_r2_fold_changes/1.json
  def update
    @auto1h_r2_fold_change = Auto1hR2FoldChange.find(params[:id])

    respond_to do |format|
      if @auto1h_r2_fold_change.update_attributes(params[:auto1h_r2_fold_change])
        format.html { redirect_to @auto1h_r2_fold_change, notice: 'Auto1h r2 fold change was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @auto1h_r2_fold_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auto1h_r2_fold_changes/1
  # DELETE /auto1h_r2_fold_changes/1.json
  def destroy
    @auto1h_r2_fold_change = Auto1hR2FoldChange.find(params[:id])
    @auto1h_r2_fold_change.destroy

    respond_to do |format|
      format.html { redirect_to auto1h_r2_fold_changes_url }
      format.json { head :no_content }
    end
  end
end
