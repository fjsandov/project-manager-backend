class TasksController < ApplicationController
  load_and_authorize_resource :project, through: :current_user
  load_and_authorize_resource :task, through: :project

  # GET /project/1/tasks
  def index
    render json: @tasks
  end

  # GET /projects/1/tasks/1
  def show
    render json: @task
  end

  # POST /projects/1/tasks
  def create
    @task = @project.tasks.new(task_params)

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
    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :priority, :deadline, :status)
    end
end
