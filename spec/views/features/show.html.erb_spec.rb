require 'spec_helper'

describe "features/show.html.erb" do
  before(:each) do
    @feature = assign(:feature, stub_model(Feature,
      :sequence_id => "",
      :annotation_id => "",
      :start_pos => "",
      :end_pos => "",
      :frame => "",
      :strand => "Strand"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Strand/)
  end
end
