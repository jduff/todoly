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

  test "find for authentication shouldn't care about email case" do
    user = Factory.build(:user, :email=>"Duff.John@gmail.com")

    assert user.save

    found = User.find_for_database_authentication(:email=>"duff.john@gmail.com")
    assert_equal user, found

    found = User.find_for_database_authentication(:email=>"Duff.John@gmail.com")
    assert_equal user, found
  end

  test "find for auth shouldn't care about login case" do
    user = Factory(:user, :login=>"jduff")

    found = User.find_for_database_authentication(:email=>"Jduff")
    assert_equal user, found

    found = User.find_for_database_authentication(:email=>"jduff")
    assert_equal user, found
  end
end
