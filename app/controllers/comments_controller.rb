class CommentsController < ApplicationController
  before_action :set_comment, only: %i(show update destroy)

  def index
    @comments = @commentable.comments
    @comments.each {|comment| authorize!(:read, comment) }
    render json: @comments
  end

  def show
    authorize! :read, @comment
    render json: @comment
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    authorize! :create, @comment
    if @comment.save
      render json: @comment, status: :created, location: comment_location
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @comment
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @comment
    @comment.destroy
  end

  private
  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
