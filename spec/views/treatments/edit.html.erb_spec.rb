require 'spec_helper'

describe "treatments/edit.html.erb" do
  before(:each) do
    @treatment = assign(:treatment, stub_model(Treatment,
      :name => "MyString",
      :description => "MyString",
      :ordering => 1
    ))
  end

  it "renders the edit treatment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => treatments_path(@treatment), :method => "post" do
      assert_select "input#treatment_name", :name => "treatment[name]"
      assert_select "input#treatment_description", :name => "treatment[description]"
      assert_select "input#treatment_ordering", :name => "treatment[ordering]"
    end
  end
end
