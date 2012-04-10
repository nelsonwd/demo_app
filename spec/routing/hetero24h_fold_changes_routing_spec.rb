require "spec_helper"

describe Hetero24hFoldChangesController do
  describe "routing" do

    it "routes to #index" do
      get("/hetero24h_fold_changes").should route_to("hetero24h_fold_changes#index")
    end

    it "routes to #new" do
      get("/hetero24h_fold_changes/new").should route_to("hetero24h_fold_changes#new")
    end

    it "routes to #show" do
      get("/hetero24h_fold_changes/1").should route_to("hetero24h_fold_changes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hetero24h_fold_changes/1/edit").should route_to("hetero24h_fold_changes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hetero24h_fold_changes").should route_to("hetero24h_fold_changes#create")
    end

    it "routes to #update" do
      put("/hetero24h_fold_changes/1").should route_to("hetero24h_fold_changes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hetero24h_fold_changes/1").should route_to("hetero24h_fold_changes#destroy", :id => "1")
    end

  end
end
