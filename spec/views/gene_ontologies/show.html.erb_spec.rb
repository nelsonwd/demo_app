require 'spec_helper'

describe "gene_ontologies/show.html.erb" do
  before(:each) do
    @gene_ontology = assign(:gene_ontology, stub_model(GeneOntology,
      :accession => "",
      :ontology_root => "",
      :keyword => "Keyword"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Keyword/)
  end
end
