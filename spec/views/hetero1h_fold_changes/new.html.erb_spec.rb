require 'spec_helper'

describe "hetero1h_fold_changes/new.html.erb" do
  before(:each) do
    assign(:hetero1h_fold_change, stub_model(Hetero1hFoldChange,
      :log2fc => 1.5,
      :fdr => 1.5,
      :pval => 1.5,
      :de_analysis_id => 1,
      :treatment_id => 1,
      :base_treatment_id => 1,
      :sequence_id => 1
    ).as_new_record)
  end

  it "renders new hetero1h_fold_change form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hetero1h_fold_changes_path, :method => "post" do
      assert_select "input#hetero1h_fold_change_log2fc", :name => "hetero1h_fold_change[log2fc]"
      assert_select "input#hetero1h_fold_change_fdr", :name => "hetero1h_fold_change[fdr]"
      assert_select "input#hetero1h_fold_change_pval", :name => "hetero1h_fold_change[pval]"
      assert_select "input#hetero1h_fold_change_de_analysis_id", :name => "hetero1h_fold_change[de_analysis_id]"
      assert_select "input#hetero1h_fold_change_treatment_id", :name => "hetero1h_fold_change[treatment_id]"
      assert_select "input#hetero1h_fold_change_base_treatment_id", :name => "hetero1h_fold_change[base_treatment_id]"
      assert_select "input#hetero1h_fold_change_sequence_id", :name => "hetero1h_fold_change[sequence_id]"
    end
  end
end
