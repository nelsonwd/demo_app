require 'spec_helper'

describe "features/index.html.erb" do
  before(:each) do
    assign(:features, [
      stub_model(Feature,
        :sequence_id => "",
        :annotation_id => "",
        :start_pos => "",
        :end_pos => "",
        :frame => "",
        :strand => "Strand"
      ),
      stub_model(Feature,
        :sequence_id => "",
        :annotation_id => "",
        :start_pos => "",
        :end_pos => "",
        :frame => "",
        :strand => "Strand"
      )
    ])
  end

  it "renders a list of features" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Strand".to_s, :count => 2
  end
end
