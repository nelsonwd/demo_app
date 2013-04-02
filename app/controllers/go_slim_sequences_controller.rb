class GoSlimSequencesController < ApplicationController
  # GET /go_slim_sequences
  # GET /go_slim_sequences.json
  def index
    @go_slim_sequences = GoSlimSequence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @go_slim_sequences }
    end
  end

  # GET /go_slim_sequences/1
  # GET /go_slim_sequences/1.json
  def show
    @go_slim_sequence = GoSlimSequence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @go_slim_sequence }
    end
  end

  # GET /go_slim_sequences/new
  # GET /go_slim_sequences/new.json
  def new
    @go_slim_sequence = GoSlimSequence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @go_slim_sequence }
    end
  end

  # GET /go_slim_sequences/1/edit
  def edit
    @go_slim_sequence = GoSlimSequence.find(params[:id])
  end

  # POST /go_slim_sequences
  # POST /go_slim_sequences.json
  def create
    @go_slim_sequence = GoSlimSequence.new(params[:go_slim_sequence])

    respond_to do |format|
      if @go_slim_sequence.save
        format.html { redirect_to @go_slim_sequence, notice: 'Go slim sequence was successfully created.' }
        format.json { render json: @go_slim_sequence, status: :created, location: @go_slim_sequence }
      else
        format.html { render action: "new" }
        format.json { render json: @go_slim_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /go_slim_sequences/1
  # PUT /go_slim_sequences/1.json
  def update
    @go_slim_sequence = GoSlimSequence.find(params[:id])

    respond_to do |format|
      if @go_slim_sequence.update_attributes(params[:go_slim_sequence])
        format.html { redirect_to @go_slim_sequence, notice: 'Go slim sequence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @go_slim_sequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /go_slim_sequences/1
  # DELETE /go_slim_sequences/1.json
  def destroy
    @go_slim_sequence = GoSlimSequence.find(params[:id])
    @go_slim_sequence.destroy

    respond_to do |format|
      format.html { redirect_to go_slim_sequences_url }
      format.json { head :no_content }
    end
  end
end
