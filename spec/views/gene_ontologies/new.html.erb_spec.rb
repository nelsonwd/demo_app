require 'spec_helper'

describe "gene_ontologies/new.html.erb" do
  before(:each) do
    assign(:gene_ontology, stub_model(GeneOntology,
      :accession => "MyString",
      :ontology_root => "MyString",
      :keyword => "MyString"
    ).as_new_record)
  end

  it "renders new gene_ontology form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => gene_ontologies_path, :method => "post" do
      assert_select "input#gene_ontology_accession", :name => "gene_ontology[accession]"
      assert_select "input#gene_ontology_ontology_root", :name => "gene_ontology[ontology_root]"
      assert_select "input#gene_ontology_keyword", :name => "gene_ontology[keyword]"
    end
  end
end
