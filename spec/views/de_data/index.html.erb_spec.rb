require 'spec_helper'

describe "de_data/index.html.erb" do
  before(:each) do
    assign(:de_data, [
      stub_model(DeDatum,
        :abundance => 1,
        :sequence_id => 1,
        :de_analysis_id => 1,
        :treatment_id => 1
      ),
      stub_model(DeDatum,
        :abundance => 1,
        :sequence_id => 1,
        :de_analysis_id => 1,
        :treatment_id => 1
      )
    ])
  end

  it "renders a list of de_data" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
