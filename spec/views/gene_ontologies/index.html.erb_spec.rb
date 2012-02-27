require 'spec_helper'

describe "gene_ontologies/index.html.erb" do
  before(:each) do
    assign(:gene_ontologies, [
      stub_model(GeneOntology,
        :accession => "Accession",
        :ontology_root => "Ontology Root",
        :keyword => "Keyword"
      ),
      stub_model(GeneOntology,
        :accession => "Accession",
        :ontology_root => "Ontology Root",
        :keyword => "Keyword"
      )
    ])
  end

  it "renders a list of gene_ontologies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Accession".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ontology Root".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Keyword".to_s, :count => 2
  end
end
