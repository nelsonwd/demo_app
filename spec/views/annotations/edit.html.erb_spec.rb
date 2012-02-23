require 'spec_helper'

describe "annotations/edit.html.erb" do
  before(:each) do
    @annotation = assign(:annotation, stub_model(Annotation,
      :accession => "",
      :desc => "",
      :annotation_source_id => "",
      :interpro_id => 1
    ))
  end

  it "renders the edit annotation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => annotations_path(@annotation), :method => "post" do
      assert_select "input#annotation_accession", :name => "annotation[accession]"
      assert_select "input#annotation_desc", :name => "annotation[desc]"
      assert_select "input#annotation_annotation_source_id", :name => "annotation[annotation_source_id]"
      assert_select "input#annotation_interpro_id", :name => "annotation[interpro_id]"
    end
  end
end
