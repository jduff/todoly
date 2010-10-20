class TasksController < ApplicationController
  load_and_authorize_resource
  before_filter :focus_tags, :only => [:index, :update, :destroy]

  def index
    @tasks = current_user.tasks.current
    @completed_tasks = current_user.tasks.status('complete')

    # Limit the tasks returned by the tags the user is currently focusing on
    focus_tasks

    @tags = current_user.owned_tags

    respond_with @tasks
  end

  def create
    @task.creator = current_user

    @task.save

    # set the tag_list to the currently focused tags
    current_user.tag(@task, :with=>focused_tags.join(','), :on=>:tags) unless focused_tags.empty?


    respond_with @task
  end

  def update
    tags = params[:task].delete(:tag_list) if params[:task]
    @task.update_attributes(params[:task])

    current_user.tag(@task, :with=>tags, :on=>:tags) if tags

    @tags = current_user.owned_tags

    respond_with @task
  end

  def destroy
    @task.destroy

    # not the most efficient, but gets the job done
    @tags = current_user.owned_tags

    respond_with @task
  end

  def complete
    @task.status = "complete"
    @task.save

    respond_with @task
  end

  def uncomplete
    @task.status = nil
    @task.save

    respond_with @task
  end

  protected
  def focus_tasks
    unless focused_tags.empty?
      @tasks = @tasks.tagged_with(focused_tags, :any => true)
      @completed_tasks = @completed_tasks.tagged_with(focused_tags, :any => true)
    end
  end

  def focus_tags
    focused_tags
    # add the new tag to the list unless it's blank or we already had it, in which case we remove it
    @focused_tags << params[:tag].strip unless params[:tag].blank? || @focused_tags.reject!{|t| t == params[:tag].strip}
    @focused_tags = [] if params[:tag].blank?
    session[:focused_tags] = @focused_tags.join(',')
  end

  def focused_tags
    @focused_tags ||= (session[:focused_tags]||"").split(',')
    @focused_tags
  end
end
