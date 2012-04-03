require 'spec_helper'

describe "de_data/edit.html.erb" do
  before(:each) do
    @de_datum = assign(:de_datum, stub_model(DeDatum,
      :abundance => 1,
      :sequence_id => 1,
      :de_analysis_id => 1,
      :treatment_id => 1
    ))
  end

  it "renders the edit de_datum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => de_data_path(@de_datum), :method => "post" do
      assert_select "input#de_datum_abundance", :name => "de_datum[abundance]"
      assert_select "input#de_datum_sequence_id", :name => "de_datum[sequence_id]"
      assert_select "input#de_datum_de_analysis_id", :name => "de_datum[de_analysis_id]"
      assert_select "input#de_datum_treatment_id", :name => "de_datum[treatment_id]"
    end
  end
end
