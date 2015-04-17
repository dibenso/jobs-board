require 'test_helper'

class JobApplicationsControllerTest < ActionController::TestCase
  setup do
    @job_application = job_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_application" do
    assert_difference('JobApplication.count') do
      post :create, job_application: { cover_letter: @job_application.cover_letter, employer_id: @job_application.employer_id, first_name: @job_application.first_name, job_id: @job_application.job_id, last_name: @job_application.last_name, user_id: @job_application.user_id }
    end

    assert_redirected_to job_application_path(assigns(:job_application))
  end

  test "should show job_application" do
    get :show, id: @job_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_application
    assert_response :success
  end

  test "should update job_application" do
    patch :update, id: @job_application, job_application: { cover_letter: @job_application.cover_letter, employer_id: @job_application.employer_id, first_name: @job_application.first_name, job_id: @job_application.job_id, last_name: @job_application.last_name, user_id: @job_application.user_id }
    assert_redirected_to job_application_path(assigns(:job_application))
  end

  test "should destroy job_application" do
    assert_difference('JobApplication.count', -1) do
      delete :destroy, id: @job_application
    end

    assert_redirected_to job_applications_path
  end
end
