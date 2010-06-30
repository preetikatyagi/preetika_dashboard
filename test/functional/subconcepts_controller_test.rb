require 'test_helper'

class SubconceptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subconcepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subconcept" do
    assert_difference('Subconcept.count') do
      post :create, :subconcept => { }
    end

    assert_redirected_to subconcept_path(assigns(:subconcept))
  end

  test "should show subconcept" do
    get :show, :id => subconcepts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => subconcepts(:one).to_param
    assert_response :success
  end

  test "should update subconcept" do
    put :update, :id => subconcepts(:one).to_param, :subconcept => { }
    assert_redirected_to subconcept_path(assigns(:subconcept))
  end

  test "should destroy subconcept" do
    assert_difference('Subconcept.count', -1) do
      delete :destroy, :id => subconcepts(:one).to_param
    end

    assert_redirected_to subconcepts_path
  end
end
