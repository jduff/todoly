require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user.tags returns list of tags used for users tasks" do
    user = Factory(:user)

    task1 = Factory(:task, :creator=>user, :tag_list=>"something, awesome")
    task2 = Factory(:task, :creator=>user, :tag_list=>"something, super")

    assert_equal 3, user.tasks.tag_counts.length
    assert user.tasks.tag_counts.collect(&:name).include?("something")
    assert user.tasks.tag_counts.collect(&:name).include?("awesome")
    assert user.tasks.tag_counts.collect(&:name).include?("super")
  end
end
