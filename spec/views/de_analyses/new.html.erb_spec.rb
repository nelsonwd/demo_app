require 'spec_helper'

describe "de_analyses/new.html.erb" do
  before(:each) do
    assign(:de_analysis, stub_model(DeAnalysis,
      :method => "MyString",
      :script_name => "MyString",
      :experiment_id => 1
    ).as_new_record)
  end

  it "renders new de_analysis form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => de_analyses_path, :method => "post" do
      assert_select "input#de_analysis_method", :name => "de_analysis[method]"
      assert_select "input#de_analysis_script_name", :name => "de_analysis[script_name]"
      assert_select "input#de_analysis_experiment_id", :name => "de_analysis[experiment_id]"
    end
  end
end
