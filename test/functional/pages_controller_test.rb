require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get blast" do
    get :blast
    assert_response :success
  end

  test "should get data" do
    get :data
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
