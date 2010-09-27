require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "should create a task" do
    task = Factory.build(:task)

    assert task.save, task.errors.full_messages
  end

  test "should require a creator" do
    task = Factory.build(:task, :creator=>nil)

    assert !task.save
    assert_equal "Creator can't be blank", task.errors.full_messages.join
  end

  test "should require a name" do
    task = Factory.build(:task, :name=>nil)

    assert !task.save
    assert_equal "Name can't be blank", task.errors.full_messages.join
  end

  test "should be able to create a task on a user" do
    user = Factory(:user)
    task = user.tasks.build(:name=>"New Task!")

    assert task.save, task.errors.full_messages
    assert_equal user, task.creator
    assert_equal "New Task!", task.name
  end
end
