require 'spec_helper'

describe "interpros/new.html.erb" do
  before(:each) do
    assign(:interpro, stub_model(Interpro,
      :accession => "",
      :desc => "",
      :gene_ontology_id => 1
    ).as_new_record)
  end

  it "renders new interpro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => interpros_path, :method => "post" do
      assert_select "input#interpro_accession", :name => "interpro[accession]"
      assert_select "input#interpro_desc", :name => "interpro[desc]"
      assert_select "input#interpro_gene_ontology_id", :name => "interpro[gene_ontology_id]"
    end
  end
end
