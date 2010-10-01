require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index when not logged in" do
    get :index
    assert_response :success
  end

  test "should redirect to tasks if logged in" do
    sign_in Factory(:user)
    get :index
    assert_redirected_to tasks_path
  end

end
