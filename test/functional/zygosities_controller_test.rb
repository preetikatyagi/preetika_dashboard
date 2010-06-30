require 'test_helper'

class ZygositiesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:zygosities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zygosity" do
    assert_difference('Zygosity.count') do
      post :create, :zygosity => { }
    end

    assert_redirected_to zygosity_path(assigns(:zygosity))
  end

  test "should show zygosity" do
    get :show, :id => zygosities(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => zygosities(:one).to_param
    assert_response :success
  end

  test "should update zygosity" do
    put :update, :id => zygosities(:one).to_param, :zygosity => { }
    assert_redirected_to zygosity_path(assigns(:zygosity))
  end

  test "should destroy zygosity" do
    assert_difference('Zygosity.count', -1) do
      delete :destroy, :id => zygosities(:one).to_param
    end

    assert_redirected_to zygosities_path
  end
end
