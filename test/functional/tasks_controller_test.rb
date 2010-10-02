require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @user = Factory(:user)
    sign_in @user
  end

  test "should be able to view all tasks on index" do
    Factory(:task, :creator=>@user)
    Factory(:task, :status=>"complete", :creator=>@user)
    Factory(:task, :status=>"in progress", :creator=>@user)

    get :index
    assert_response :success
  end

  test "should be able to create a task" do
    assert_difference "Task.count" do
      post :create, :format=>:js, :task=>{:name=>"New Task"}

      assert_response :success

      assert_match /New Task/, response.body
      assert_equal @user, assigns(:task).creator
    end
  end

  test "should be able to delete a task" do
    task = Factory(:task, :creator=>@user)
    assert_difference "Task.count", -1 do
      delete :destroy, :format=>:js, :id=>task.id

      assert_response :success

      assert_match "$('#task_'+#{task.id}).remove()", response.body
    end
  end

  test "should not be able to delete another users task" do
    task = Factory(:task)
    assert_no_difference "Task.count" do
      delete :destroy, :format=>:js, :id=>task.id

      assert_redirected_to tasks_url
      assert_equal "You are not authorized to access this page.", flash[:alert]
    end
  end
end
