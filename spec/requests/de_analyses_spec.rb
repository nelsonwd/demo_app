require 'spec_helper'

describe "DeAnalyses" do
  describe "GET /de_analyses" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get de_analyses_path
      response.status.should be(200)
    end
  end
end
