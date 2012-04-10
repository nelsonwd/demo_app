require 'spec_helper'

describe "Auto24hFoldChanges" do
  describe "GET /auto24h_fold_changes" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get auto24h_fold_changes_path
      response.status.should be(200)
    end
  end
end
