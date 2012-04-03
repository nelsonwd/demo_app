require "spec_helper"

describe DeAnalysesController do
  describe "routing" do

    it "routes to #index" do
      get("/de_analyses").should route_to("de_analyses#index")
    end

    it "routes to #new" do
      get("/de_analyses/new").should route_to("de_analyses#new")
    end

    it "routes to #show" do
      get("/de_analyses/1").should route_to("de_analyses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/de_analyses/1/edit").should route_to("de_analyses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/de_analyses").should route_to("de_analyses#create")
    end

    it "routes to #update" do
      put("/de_analyses/1").should route_to("de_analyses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/de_analyses/1").should route_to("de_analyses#destroy", :id => "1")
    end

  end
end
