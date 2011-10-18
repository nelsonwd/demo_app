require 'test_helper'

class BlastDbsControllerTest < ActionController::TestCase
  setup do
    @blast_db = blast_dbs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blast_dbs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blast_db" do
    assert_difference('BlastDb.count') do
      post :create, :blast_db => @blast_db.attributes
    end

    assert_redirected_to blast_db_path(assigns(:blast_db))
  end

  test "should show blast_db" do
    get :show, :id => @blast_db.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @blast_db.to_param
    assert_response :success
  end

  test "should update blast_db" do
    put :update, :id => @blast_db.to_param, :blast_db => @blast_db.attributes
    assert_redirected_to blast_db_path(assigns(:blast_db))
  end

  test "should destroy blast_db" do
    assert_difference('BlastDb.count', -1) do
      delete :destroy, :id => @blast_db.to_param
    end

    assert_redirected_to blast_dbs_path
  end
end
