require "spec_helper"

describe DeDataController do
  describe "routing" do

    it "routes to #index" do
      get("/de_data").should route_to("de_data#index")
    end

    it "routes to #new" do
      get("/de_data/new").should route_to("de_data#new")
    end

    it "routes to #show" do
      get("/de_data/1").should route_to("de_data#show", :id => "1")
    end

    it "routes to #edit" do
      get("/de_data/1/edit").should route_to("de_data#edit", :id => "1")
    end

    it "routes to #create" do
      post("/de_data").should route_to("de_data#create")
    end

    it "routes to #update" do
      put("/de_data/1").should route_to("de_data#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/de_data/1").should route_to("de_data#destroy", :id => "1")
    end

  end
end
