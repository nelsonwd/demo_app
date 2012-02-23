require 'spec_helper'

describe "sequences/index.html.erb" do
  before(:each) do
    assign(:sequences, [
      stub_model(Sequence,
        :acc => "Acc",
        :name => "Name",
        :desc => "Desc",
        :na_seq => "MyText",
        :blast_db_id => 1
      ),
      stub_model(Sequence,
        :acc => "Acc",
        :name => "Name",
        :desc => "Desc",
        :na_seq => "MyText",
        :blast_db_id => 1
      )
    ])
  end

  it "renders a list of sequences" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Acc".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Desc".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
