require 'spec_helper'

describe "experiments/edit.html.erb" do
  before(:each) do
    @experiment = assign(:experiment, stub_model(Experiment,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit experiment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => experiments_path(@experiment), :method => "post" do
      assert_select "input#experiment_name", :name => "experiment[name]"
      assert_select "input#experiment_description", :name => "experiment[description]"
    end
  end
end
