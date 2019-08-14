class Projects::CommentsController < CommentsController
  prepend_before_action :set_commentable

  private
  def set_commentable
    @commentable = current_user.projects.find(params[:project_id])
    authorize! :read, @commentable
  end

  def comment_location
    url_for([@commentable, @comment])
  end
end
