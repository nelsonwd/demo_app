require 'spec_helper'

describe "sequences/new.html.erb" do
  before(:each) do
    assign(:sequence, stub_model(Sequence,
      :acc => "MyString",
      :name => "MyString",
      :desc => "MyString",
      :na_seq => "MyText",
      :blast_db_id => 1
    ).as_new_record)
  end

  it "renders new sequence form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sequences_path, :method => "post" do
      assert_select "input#sequence_acc", :name => "sequence[acc]"
      assert_select "input#sequence_name", :name => "sequence[name]"
      assert_select "input#sequence_desc", :name => "sequence[desc]"
      assert_select "textarea#sequence_na_seq", :name => "sequence[na_seq]"
      assert_select "input#sequence_blast_db_id", :name => "sequence[blast_db_id]"
    end
  end
end
