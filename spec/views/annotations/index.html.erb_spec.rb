require 'spec_helper'

describe "annotations/index.html.erb" do
  before(:each) do
    assign(:annotations, [
      stub_model(Annotation,
        :accession => "",
        :desc => "",
        :annotation_source_id => "",
        :interpro_id => 1
      ),
      stub_model(Annotation,
        :accession => "",
        :desc => "",
        :annotation_source_id => "",
        :interpro_id => 1
      )
    ])
  end

  it "renders a list of annotations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
