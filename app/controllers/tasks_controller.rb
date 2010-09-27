class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @tasks = current_user.tasks
    respond_with @tasks
  end
end
