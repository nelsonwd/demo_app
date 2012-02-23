require 'spec_helper'

describe "annotations/show.html.erb" do
  before(:each) do
    @annotation = assign(:annotation, stub_model(Annotation,
      :accession => "",
      :desc => "",
      :annotation_source_id => "",
      :interpro_id => 1
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
    rendered.should match(/1/)
  end
end
