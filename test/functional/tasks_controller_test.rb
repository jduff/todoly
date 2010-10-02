require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should be able to view all tasks on index" do
    user = Factory(:user)
    sign_in user
    Factory(:task, :creator=>user)
    Factory(:task, :status=>"complete", :creator=>user)
    Factory(:task, :status=>"in progress", :creator=>user)

    get :index
    assert_response :success
  end
end
