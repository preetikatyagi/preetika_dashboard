require 'test_helper'

class DelayedJobsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delayed_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delayed_job" do
    assert_difference('DelayedJob.count') do
      post :create, :delayed_job => { }
    end

    assert_redirected_to delayed_job_path(assigns(:delayed_job))
  end

  test "should show delayed_job" do
    get :show, :id => delayed_jobs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => delayed_jobs(:one).to_param
    assert_response :success
  end

  test "should update delayed_job" do
    put :update, :id => delayed_jobs(:one).to_param, :delayed_job => { }
    assert_redirected_to delayed_job_path(assigns(:delayed_job))
  end

  test "should destroy delayed_job" do
    assert_difference('DelayedJob.count', -1) do
      delete :destroy, :id => delayed_jobs(:one).to_param
    end

    assert_redirected_to delayed_jobs_path
  end
end
