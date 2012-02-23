require "spec_helper"

describe AnnotationSourcesController do
  describe "routing" do

    it "routes to #index" do
      get("/annotation_sources").should route_to("annotation_sources#index")
    end

    it "routes to #new" do
      get("/annotation_sources/new").should route_to("annotation_sources#new")
    end

    it "routes to #show" do
      get("/annotation_sources/1").should route_to("annotation_sources#show", :id => "1")
    end

    it "routes to #edit" do
      get("/annotation_sources/1/edit").should route_to("annotation_sources#edit", :id => "1")
    end

    it "routes to #create" do
      post("/annotation_sources").should route_to("annotation_sources#create")
    end

    it "routes to #update" do
      put("/annotation_sources/1").should route_to("annotation_sources#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/annotation_sources/1").should route_to("annotation_sources#destroy", :id => "1")
    end

  end
end
