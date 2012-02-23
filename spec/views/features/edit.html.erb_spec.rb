require 'spec_helper'

describe "features/edit.html.erb" do
  before(:each) do
    @feature = assign(:feature, stub_model(Feature,
      :sequence_id => "",
      :annotation_id => "",
      :start_pos => "",
      :end_pos => "",
      :frame => "",
      :strand => "MyString"
    ))
  end

  it "renders the edit feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => features_path(@feature), :method => "post" do
      assert_select "input#feature_sequence_id", :name => "feature[sequence_id]"
      assert_select "input#feature_annotation_id", :name => "feature[annotation_id]"
      assert_select "input#feature_start_pos", :name => "feature[start_pos]"
      assert_select "input#feature_end_pos", :name => "feature[end_pos]"
      assert_select "input#feature_frame", :name => "feature[frame]"
      assert_select "input#feature_strand", :name => "feature[strand]"
    end
  end
end
