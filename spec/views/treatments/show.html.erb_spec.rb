require 'spec_helper'

describe "treatments/show.html.erb" do
  before(:each) do
    @treatment = assign(:treatment, stub_model(Treatment,
      :name => "Name",
      :description => "Description",
      :ordering => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
