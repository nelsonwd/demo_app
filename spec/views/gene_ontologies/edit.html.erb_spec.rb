require 'spec_helper'

describe "gene_ontologies/edit.html.erb" do
  before(:each) do
    @gene_ontology = assign(:gene_ontology, stub_model(GeneOntology,
      :accession => "MyString",
      :ontology_root => "MyString",
      :keyword => "MyString"
    ))
  end

  it "renders the edit gene_ontology form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gene_ontologies_path(@gene_ontology), :method => "post" do
      assert_select "input#gene_ontology_accession", :name => "gene_ontology[accession]"
      assert_select "input#gene_ontology_ontology_root", :name => "gene_ontology[ontology_root]"
      assert_select "input#gene_ontology_keyword", :name => "gene_ontology[keyword]"
    end
  end
end
