require 'test_helper'

class BlastControllerTest < ActionController::TestCase
  test "should get submit" do
    get :submit
    assert_response :success
  end

  test "should get wait" do
    get :wait
    assert_response :success
  end

  test "should get result" do
    get :result
    assert_response :success
  end

end
