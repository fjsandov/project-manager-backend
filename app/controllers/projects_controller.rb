class ProjectsController < ApplicationController
  load_and_authorize_resource

  # GET /projects
  def index
    render json: @projects
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :project_type, :start_at, :end_at)
    end
end
