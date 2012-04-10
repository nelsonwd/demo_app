require 'spec_helper'

describe "hetero1h_fold_changes/index.html.erb" do
  before(:each) do
    assign(:hetero1h_fold_changes, [
      stub_model(Hetero1hFoldChange,
        :log2fc => 1.5,
        :fdr => 1.5,
        :pval => 1.5,
        :de_analysis_id => 1,
        :treatment_id => 1,
        :base_treatment_id => 1,
        :sequence_id => 1
      ),
      stub_model(Hetero1hFoldChange,
        :log2fc => 1.5,
        :fdr => 1.5,
        :pval => 1.5,
        :de_analysis_id => 1,
        :treatment_id => 1,
        :base_treatment_id => 1,
        :sequence_id => 1
      )
    ])
  end

  it "renders a list of hetero1h_fold_changes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
