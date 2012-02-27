require 'spec_helper'

describe "interpros/edit.html.erb" do
  before(:each) do
    @interpro = assign(:interpro, stub_model(Interpro,
      :accession => "MyString",
      :desc => "MyString"
    ))
  end

  it "renders the edit interpro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => interpros_path(@interpro), :method => "post" do
      assert_select "input#interpro_accession", :name => "interpro[accession]"
      assert_select "input#interpro_desc", :name => "interpro[desc]"
    end
  end
end
