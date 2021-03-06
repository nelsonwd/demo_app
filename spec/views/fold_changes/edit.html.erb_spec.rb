require 'spec_helper'

describe "fold_changes/edit.html.erb" do
  before(:each) do
    @fold_change = assign(:fold_change, stub_model(FoldChange,
      :log2fc => 1.5,
      :fdr => 1.5,
      :pval => 1.5,
      :de_analysis_id => 1,
      :treatment_id => 1,
      :base_treatment_id => 1,
      :sequence_id => 1
    ))
  end

  it "renders the edit fold_change form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fold_changes_path(@fold_change), :method => "post" do
      assert_select "input#fold_change_log2fc", :name => "fold_change[log2fc]"
      assert_select "input#fold_change_fdr", :name => "fold_change[fdr]"
      assert_select "input#fold_change_pval", :name => "fold_change[pval]"
      assert_select "input#fold_change_de_analysis_id", :name => "fold_change[de_analysis_id]"
      assert_select "input#fold_change_treatment_id", :name => "fold_change[treatment_id]"
      assert_select "input#fold_change_base_treatment_id", :name => "fold_change[base_treatment_id]"
      assert_select "input#fold_change_sequence_id", :name => "fold_change[sequence_id]"
    end
  end
end
