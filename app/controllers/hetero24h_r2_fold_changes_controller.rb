
class Hetero24hR2FoldChangesController < ApplicationController
  # GET /hetero24h_r2_fold_changes
  # GET /hetero24h_r2_fold_changes.json
  def index
    @hetero24h_r2_fold_changes = Hetero24hR2FoldChange.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hetero24h_r2_fold_changes }
    end
  end

  # GET /hetero24h_r2_fold_changes/1
  # GET /hetero24h_r2_fold_changes/1.json
  def show
    @hetero24h_r2_fold_change = Hetero24hR2FoldChange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hetero24h_r2_fold_change }
    end
  end

  # GET /hetero24h_r2_fold_changes/new
  # GET /hetero24h_r2_fold_changes/new.json
  def new
    @hetero24h_r2_fold_change = Hetero24hR2FoldChange.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hetero24h_r2_fold_change }
    end
  end

  # GET /hetero24h_r2_fold_changes/1/edit
  def edit
    @hetero24h_r2_fold_change = Hetero24hR2FoldChange.find(params[:id])
  end

  # POST /hetero24h_r2_fold_changes
  # POST /hetero24h_r2_fold_changes.json
  def create
    @hetero24h_r2_fold_change = Hetero24hR2FoldChange.new(params[:hetero24h_r2_fold_change])

    respond_to do |format|
      if @hetero24h_r2_fold_change.save
        format.html { redirect_to @hetero24h_r2_fold_change, notice: 'Hetero24h r2 fold change was successfully created.' }
        format.json { render json: @hetero24h_r2_fold_change, status: :created, location: @hetero24h_r2_fold_change }
      else
        format.html { render action: "new" }
        format.json { render json: @hetero24h_r2_fold_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hetero24h_r2_fold_changes/1
  # PUT /hetero24h_r2_fold_changes/1.json
  def update
    @hetero24h_r2_fold_change = Hetero24hR2FoldChange.find(params[:id])

    respond_to do |format|
      if @hetero24h_r2_fold_change.update_attributes(params[:hetero24h_r2_fold_change])
        format.html { redirect_to @hetero24h_r2_fold_change, notice: 'Hetero24h r2 fold change was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hetero24h_r2_fold_change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hetero24h_r2_fold_changes/1
  # DELETE /hetero24h_r2_fold_changes/1.json
  def destroy
    @hetero24h_r2_fold_change = Hetero24hR2FoldChange.find(params[:id])
    @hetero24h_r2_fold_change.destroy

    respond_to do |format|
      format.html { redirect_to hetero24h_r2_fold_changes_url }
      format.json { head :no_content }
    end
  end
end
