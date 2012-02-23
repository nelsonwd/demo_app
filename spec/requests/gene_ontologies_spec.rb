require 'spec_helper'

describe "GeneOntologies" do
  describe "GET /gene_ontologies" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get gene_ontologies_path
      response.status.should be(200)
    end
  end
end
