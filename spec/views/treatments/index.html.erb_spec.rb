require 'spec_helper'

describe "treatments/index.html.erb" do
  before(:each) do
    assign(:treatments, [
      stub_model(Treatment,
        :name => "Name",
        :description => "Description",
        :ordering => 1
      ),
      stub_model(Treatment,
        :name => "Name",
        :description => "Description",
        :ordering => 1
      )
    ])
  end

  it "renders a list of treatments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
