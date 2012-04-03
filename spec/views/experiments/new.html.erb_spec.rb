require 'spec_helper'

describe "experiments/new.html.erb" do
  before(:each) do
    assign(:experiment, stub_model(Experiment,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new experiment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => experiments_path, :method => "post" do
      assert_select "input#experiment_name", :name => "experiment[name]"
      assert_select "input#experiment_description", :name => "experiment[description]"
    end
  end
end
