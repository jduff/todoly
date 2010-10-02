class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @tasks = current_user.tasks.current
    @completed_tasks = current_user.tasks.status('complete')
  end

  def create
    @task.creator = current_user
    @task.save

    respond_with @task do |format|
      format.js { render }
    end
  end

  def destroy
    @task.destroy

    respond_with @task
  end

  def complete
    @task.update_attributes(:status=>"complete")

    respond_with @task
  end
end
