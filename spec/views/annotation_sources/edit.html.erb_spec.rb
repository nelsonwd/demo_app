require 'spec_helper'

describe "annotation_sources/edit.html.erb" do
  before(:each) do
    @annotation_source = assign(:annotation_source, stub_model(AnnotationSource,
      :name => "",
      :url => "MyString"
    ))
  end

  it "renders the edit annotation_source form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => annotation_sources_path(@annotation_source), :method => "post" do
      assert_select "input#annotation_source_name", :name => "annotation_source[name]"
      assert_select "input#annotation_source_url", :name => "annotation_source[url]"
    end
  end
end
