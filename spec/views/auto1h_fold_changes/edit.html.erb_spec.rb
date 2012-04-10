require 'spec_helper'

describe "auto1h_fold_changes/edit.html.erb" do
  before(:each) do
    @auto1h_fold_change = assign(:auto1h_fold_change, stub_model(Auto1hFoldChange,
      :log2fc => 1.5,
      :fdr => 1.5,
      :pval => 1.5,
      :de_analysis_id => 1,
      :treatment_id => 1,
      :base_treatment_id => 1,
      :sequence_id => 1
    ))
  end

  it "renders the edit auto1h_fold_change form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => auto1h_fold_changes_path(@auto1h_fold_change), :method => "post" do
      assert_select "input#auto1h_fold_change_log2fc", :name => "auto1h_fold_change[log2fc]"
      assert_select "input#auto1h_fold_change_fdr", :name => "auto1h_fold_change[fdr]"
      assert_select "input#auto1h_fold_change_pval", :name => "auto1h_fold_change[pval]"
      assert_select "input#auto1h_fold_change_de_analysis_id", :name => "auto1h_fold_change[de_analysis_id]"
      assert_select "input#auto1h_fold_change_treatment_id", :name => "auto1h_fold_change[treatment_id]"
      assert_select "input#auto1h_fold_change_base_treatment_id", :name => "auto1h_fold_change[base_treatment_id]"
      assert_select "input#auto1h_fold_change_sequence_id", :name => "auto1h_fold_change[sequence_id]"
    end
  end
end
