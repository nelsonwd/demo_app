require 'spec_helper'

describe "fold_changes/show.html.erb" do
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

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
