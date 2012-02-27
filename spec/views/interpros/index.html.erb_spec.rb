require 'spec_helper'

describe "interpros/index.html.erb" do
  before(:each) do
    assign(:interpros, [
      stub_model(Interpro,
        :accession => "Accession",
        :desc => "Desc"
      ),
      stub_model(Interpro,
        :accession => "Accession",
        :desc => "Desc"
      )
    ])
  end

  it "renders a list of interpros" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Accession".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Desc".to_s, :count => 2
  end
end
