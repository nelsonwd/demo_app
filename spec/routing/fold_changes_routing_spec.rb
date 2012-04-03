require "spec_helper"

describe FoldChangesController do
  describe "routing" do

    it "routes to #index" do
      get("/fold_changes").should route_to("fold_changes#index")
    end

    it "routes to #new" do
      get("/fold_changes/new").should route_to("fold_changes#new")
    end

    it "routes to #show" do
      get("/fold_changes/1").should route_to("fold_changes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fold_changes/1/edit").should route_to("fold_changes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fold_changes").should route_to("fold_changes#create")
    end

    it "routes to #update" do
      put("/fold_changes/1").should route_to("fold_changes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fold_changes/1").should route_to("fold_changes#destroy", :id => "1")
    end

  end
end
