class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @tasks = current_user.tasks
    respond_with @tasks
  end

  def create
    @task.creator = current_user
    @task.save

    respond_with @task do |format|
      format.js { render }
    end
  end
end
