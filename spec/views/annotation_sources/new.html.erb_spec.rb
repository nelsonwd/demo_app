require 'spec_helper'

describe "annotation_sources/new.html.erb" do
  before(:each) do
    assign(:annotation_source, stub_model(AnnotationSource,
      :name => "",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new annotation_source form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => annotation_sources_path, :method => "post" do
      assert_select "input#annotation_source_name", :name => "annotation_source[name]"
      assert_select "input#annotation_source_url", :name => "annotation_source[url]"
    end
  end
end
