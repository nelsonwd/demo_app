require 'spec_helper'

describe "sequences/show.html.erb" do
  before(:each) do
    @sequence = assign(:sequence, stub_model(Sequence,
      :acc => "Acc",
      :name => "Name",
      :desc => "Desc",
      :na_seq => "MyText",
      :blast_db_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Acc/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Desc/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
