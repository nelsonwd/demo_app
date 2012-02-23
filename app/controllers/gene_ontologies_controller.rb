class GeneOntologiesController < ApplicationController
  # GET /gene_ontologies
  # GET /gene_ontologies.xml
  def index
    @gene_ontologies = GeneOntology.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gene_ontologies }
    end
  end

  # GET /gene_ontologies/1
  # GET /gene_ontologies/1.xml
  def show
    @gene_ontology = GeneOntology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gene_ontology }
    end
  end

  # GET /gene_ontologies/new
  # GET /gene_ontologies/new.xml
  def new
    @gene_ontology = GeneOntology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gene_ontology }
    end
  end

  # GET /gene_ontologies/1/edit
  def edit
    @gene_ontology = GeneOntology.find(params[:id])
  end

  # POST /gene_ontologies
  # POST /gene_ontologies.xml
  def create
    @gene_ontology = GeneOntology.new(params[:gene_ontology])

    respond_to do |format|
      if @gene_ontology.save
        format.html { redirect_to(@gene_ontology, :notice => 'Gene ontology was successfully created.') }
        format.xml  { render :xml => @gene_ontology, :status => :created, :location => @gene_ontology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gene_ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gene_ontologies/1
  # PUT /gene_ontologies/1.xml
  def update
    @gene_ontology = GeneOntology.find(params[:id])

    respond_to do |format|
      if @gene_ontology.update_attributes(params[:gene_ontology])
        format.html { redirect_to(@gene_ontology, :notice => 'Gene ontology was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gene_ontology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gene_ontologies/1
  # DELETE /gene_ontologies/1.xml
  def destroy
    @gene_ontology = GeneOntology.find(params[:id])
    @gene_ontology.destroy

    respond_to do |format|
      format.html { redirect_to(gene_ontologies_url) }
      format.xml  { head :ok }
    end
  end
end
