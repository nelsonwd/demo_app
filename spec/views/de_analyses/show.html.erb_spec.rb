require 'spec_helper'

describe "de_analyses/show.html.erb" do
  before(:each) do
    @de_analysis = assign(:de_analysis, stub_model(DeAnalysis,
      :method => "Method",
      :script_name => "Script Name",
      :experiment_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Method/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Script Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
