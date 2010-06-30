require 'test_helper'

class ChromosomesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chromosomes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chromosome" do
    assert_difference('Chromosome.count') do
      post :create, :chromosome => { }
    end

    assert_redirected_to chromosome_path(assigns(:chromosome))
  end

  test "should show chromosome" do
    get :show, :id => chromosomes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => chromosomes(:one).to_param
    assert_response :success
  end

  test "should update chromosome" do
    put :update, :id => chromosomes(:one).to_param, :chromosome => { }
    assert_redirected_to chromosome_path(assigns(:chromosome))
  end

  test "should destroy chromosome" do
    assert_difference('Chromosome.count', -1) do
      delete :destroy, :id => chromosomes(:one).to_param
    end

    assert_redirected_to chromosomes_path
  end
end
