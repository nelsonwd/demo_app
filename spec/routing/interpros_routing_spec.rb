require "spec_helper"

describe InterprosController do
  describe "routing" do

    it "routes to #index" do
      get("/interpros").should route_to("interpros#index")
    end

    it "routes to #new" do
      get("/interpros/new").should route_to("interpros#new")
    end

    it "routes to #show" do
      get("/interpros/1").should route_to("interpros#show", :id => "1")
    end

    it "routes to #edit" do
      get("/interpros/1/edit").should route_to("interpros#edit", :id => "1")
    end

    it "routes to #create" do
      post("/interpros").should route_to("interpros#create")
    end

    it "routes to #update" do
      put("/interpros/1").should route_to("interpros#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/interpros/1").should route_to("interpros#destroy", :id => "1")
    end

  end
end
