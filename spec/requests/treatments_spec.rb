require 'spec_helper'

describe "Treatments" do
  describe "GET /treatments" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get treatments_path
      response.status.should be(200)
    end
  end
end
