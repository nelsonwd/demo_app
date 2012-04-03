require 'spec_helper'

describe "de_data/new.html.erb" do
  before(:each) do
    assign(:de_datum, stub_model(DeDatum,
      :abundance => 1,
      :sequence_id => 1,
      :de_analysis_id => 1,
      :treatment_id => 1
    ).as_new_record)
  end

  it "renders new de_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => de_data_path, :method => "post" do
      assert_select "input#de_datum_abundance", :name => "de_datum[abundance]"
      assert_select "input#de_datum_sequence_id", :name => "de_datum[sequence_id]"
      assert_select "input#de_datum_de_analysis_id", :name => "de_datum[de_analysis_id]"
      assert_select "input#de_datum_treatment_id", :name => "de_datum[treatment_id]"
    end
  end
end
