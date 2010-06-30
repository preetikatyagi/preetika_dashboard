require 'test_helper'

class AberrationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aberrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aberration" do
    assert_difference('Aberration.count') do
      post :create, :aberration => { }
    end

    assert_redirected_to aberration_path(assigns(:aberration))
  end

  test "should show aberration" do
    get :show, :id => aberrations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => aberrations(:one).to_param
    assert_response :success
  end

  test "should update aberration" do
    put :update, :id => aberrations(:one).to_param, :aberration => { }
    assert_redirected_to aberration_path(assigns(:aberration))
  end

  test "should destroy aberration" do
    assert_difference('Aberration.count', -1) do
      delete :destroy, :id => aberrations(:one).to_param
    end

    assert_redirected_to aberrations_path
  end
end
