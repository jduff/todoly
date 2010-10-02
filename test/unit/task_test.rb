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

  test "should find task by status" do
    complete    = Factory(:task, :status=>"complete")
    in_progress = Factory(:task, :status=>"in progress")
    todo        = Factory(:task)

    tasks = Task.status("complete")
    assert_equal 1, tasks.length
    assert_equal complete, tasks.first

    tasks = Task.status("in progress")
    assert_equal 1, tasks.length
    assert_equal in_progress, tasks.first
  end

  test "should find current tasks" do
    complete    = Factory(:task, :status=>"complete")
    in_progress = Factory(:task, :status=>"in progress")
    todo        = Factory(:task)

    tasks = Task.current
    assert_equal 2, tasks.length
    assert tasks.include?(in_progress)
    assert tasks.include?(todo)
  end

  test "status question methods" do
    complete    = Factory(:task, :status=>"complete")
    in_progress = Factory(:task, :status=>"in progress")
    todo        = Factory(:task)

    assert complete.complete?
    assert !complete.in_progress?

    assert in_progress.in_progress?
    assert !in_progress.complete?

    assert !todo.complete?
    assert !todo.in_progress?
  end
end
