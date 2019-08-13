class TasksController < ApplicationController
  actions_with_task = %i(show update destroy)
  before_action :set_project, except: actions_with_task
  before_action :set_project_and_task, only: actions_with_task

  # GET /project/1/tasks
  def index
    @tasks = @project.tasks.all
    render json: @tasks
  end

  # GET /projects/1/tasks/1
  def show
    render json: @task
  end

  # POST /projects/1/tasks
  def create
    @task = Task.new(task_params)
    @task.project = @project

    if @task.save
      render json: @task, status: :created, location: url_for([@project, @task])
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1/tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1/tasks/1
  def destroy
    @task.destroy
  end

  private
    def set_project
      @project = current_user.projects.find(params[:project_id])
    end

    def set_project_and_task
      @project = current_user.projects.find(params[:project_id])
      @task = @project.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :priority, :deadline, :status)
    end
end
