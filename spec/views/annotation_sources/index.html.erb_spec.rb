require 'spec_helper'

describe "annotation_sources/index.html.erb" do
  before(:each) do
    assign(:annotation_sources, [
      stub_model(AnnotationSource,
        :name => "",
        :url => "Url"
      ),
      stub_model(AnnotationSource,
        :name => "",
        :url => "Url"
      )
    ])
  end

  it "renders a list of annotation_sources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
