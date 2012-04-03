require 'spec_helper'

describe "de_data/show.html.erb" do
  before(:each) do
    @de_datum = assign(:de_datum, stub_model(DeDatum,
      :abundance => 1,
      :sequence_id => 1,
      :de_analysis_id => 1,
      :treatment_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
