class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.developer?
     if params[:query].present?
       @projects = current_user.projects.where('name LIKE ?', "%#{params[:query]}%")
     else
       @projects = current_user.projects
     end
    else
     if params[:query].present?
       @projects = Project.where('name LIKE ?', "%#{params[:query]}%")
     else
       @projects = Project.all
     end
    end
  end

  def new
    @project = Project.new
    @users = User.where(user_type: ['developer', 'qa']) 
  end

  def show
    @project = Project.find(params[:id])
    @bugs = @project.bugs  
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id 

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      @users = User.where(user_type: ['developer', 'qa'])  
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @users = User.where(user_type: ['developer', 'qa'])  
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      @users = User.where(user_type: ['developer', 'qa']) 
      render :edit
    end
  end

def destroy
    @project = Project.find(params[:id])
    authorize! :destroy, @project
    @project.destroy
    redirect_to projects_path, notice: 'Project deleted successfully!'
  end
  private

  def project_params
    params.require(:project).permit(:name, :description, user_ids: [])
  end
end
