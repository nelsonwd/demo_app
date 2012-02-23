require 'spec_helper'

describe "annotation_sources/show.html.erb" do
  before(:each) do
    @annotation_source = assign(:annotation_source, stub_model(AnnotationSource,
      :name => "",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
