class Tasks::CommentsController < CommentsController
  prepend_before_action :set_commentable

  private
  def set_commentable
    @project = current_user.projects.find(params[:project_id])
    authorize! :read, @project
    @commentable = @project.tasks.find(params[:task_id])
    authorize! :read, @commentable
  end

  def comment_location
    url_for([@project, @commentable, @comment])
  end
end
