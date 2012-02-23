require "spec_helper"

describe GeneOntologiesController do
  describe "routing" do

    it "routes to #index" do
      get("/gene_ontologies").should route_to("gene_ontologies#index")
    end

    it "routes to #new" do
      get("/gene_ontologies/new").should route_to("gene_ontologies#new")
    end

    it "routes to #show" do
      get("/gene_ontologies/1").should route_to("gene_ontologies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/gene_ontologies/1/edit").should route_to("gene_ontologies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/gene_ontologies").should route_to("gene_ontologies#create")
    end

    it "routes to #update" do
      put("/gene_ontologies/1").should route_to("gene_ontologies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/gene_ontologies/1").should route_to("gene_ontologies#destroy", :id => "1")
    end

  end
end
