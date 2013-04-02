class GoSlimsController < ApplicationController
  # GET /go_slims
  # GET /go_slims.json
  def index
    @go_slims = GoSlim.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @go_slims }
    end
  end

  # GET /go_slims/1
  # GET /go_slims/1.json
  def show
    @go_slim = GoSlim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @go_slim }
    end
  end

  # GET /go_slims/new
  # GET /go_slims/new.json
  def new
    @go_slim = GoSlim.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @go_slim }
    end
  end

  # GET /go_slims/1/edit
  def edit
    @go_slim = GoSlim.find(params[:id])
  end

  # POST /go_slims
  # POST /go_slims.json
  def create
    @go_slim = GoSlim.new(params[:go_slim])

    respond_to do |format|
      if @go_slim.save
        format.html { redirect_to @go_slim, notice: 'Go slim was successfully created.' }
        format.json { render json: @go_slim, status: :created, location: @go_slim }
      else
        format.html { render action: "new" }
        format.json { render json: @go_slim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /go_slims/1
  # PUT /go_slims/1.json
  def update
    @go_slim = GoSlim.find(params[:id])

    respond_to do |format|
      if @go_slim.update_attributes(params[:go_slim])
        format.html { redirect_to @go_slim, notice: 'Go slim was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @go_slim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /go_slims/1
  # DELETE /go_slims/1.json
  def destroy
    @go_slim = GoSlim.find(params[:id])
    @go_slim.destroy

    respond_to do |format|
      format.html { redirect_to go_slims_url }
      format.json { head :no_content }
    end
  end
end
