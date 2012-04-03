require 'spec_helper'

describe "de_analyses/index.html.erb" do
  before(:each) do
    assign(:de_analyses, [
      stub_model(DeAnalysis,
        :method => "Method",
        :script_name => "Script Name",
        :experiment_id => 1
      ),
      stub_model(DeAnalysis,
        :method => "Method",
        :script_name => "Script Name",
        :experiment_id => 1
      )
    ])
  end

  it "renders a list of de_analyses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Method".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Script Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
