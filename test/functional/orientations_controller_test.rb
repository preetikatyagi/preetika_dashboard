require 'test_helper'

class OrientationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orientations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create orientation" do
    assert_difference('Orientation.count') do
      post :create, :orientation => { }
    end

    assert_redirected_to orientation_path(assigns(:orientation))
  end

  test "should show orientation" do
    get :show, :id => orientations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => orientations(:one).to_param
    assert_response :success
  end

  test "should update orientation" do
    put :update, :id => orientations(:one).to_param, :orientation => { }
    assert_redirected_to orientation_path(assigns(:orientation))
  end

  test "should destroy orientation" do
    assert_difference('Orientation.count', -1) do
      delete :destroy, :id => orientations(:one).to_param
    end

    assert_redirected_to orientations_path
  end
end
