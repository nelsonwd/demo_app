require 'spec_helper'

describe "interpros/show.html.erb" do
  before(:each) do
    @interpro = assign(:interpro, stub_model(Interpro,
      :accession => "",
      :desc => "",
      :gene_ontology_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
