require 'spec_helper'

describe "interpros/show.html.erb" do
  before(:each) do
    @interpro = assign(:interpro, stub_model(Interpro,
      :accession => "Accession",
      :desc => "Desc"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Accession/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Desc/)
  end
end
