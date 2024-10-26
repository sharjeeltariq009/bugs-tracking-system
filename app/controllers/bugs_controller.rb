class BugsController < ApplicationController
  before_action :set_project
  before_action :find_bug, only: [:show, :edit, :update, :destroy, :assign_to_self]
  before_action :set_bug, only: [:show, :update_status]
    
  def update_status
  if @bug.update_column(:status, params[:bug][:status])
    redirect_to project_bug_path(@project, @bug), notice: "Bug status updated successfully."
  else
    redirect_to project_bug_path(@project, @bug), alert: "Failed to update status."
  end
end

def assign_to_self
  if @bug.developer_id && @bug.developer_id != current_user.id
    # Reassigning the bug to the current user
    if @bug.update_column(:developer_id, current_user.id)
      redirect_to project_bug_path(@project, @bug), notice: "Bug successfully reassigned to you."
    else
      redirect_to project_bug_path(@project, @bug), alert: "Failed to reassign bug."
    end
  elsif @bug.developer_id.nil?
    # Assigning the bug to the current user for the first time
    if @bug.update_column(:developer_id, current_user.id)
      redirect_to project_bug_path(@project, @bug), notice: "Bug assigned to you successfully."
    else
      redirect_to project_bug_path(@project, @bug), alert: "Failed to assign bug."
    end
  else
    redirect_to project_bug_path(@project, @bug), alert: "You are already assigned to this bug."
  end
end

  def index
    @bugs = @project.bugs
  end

   def show
      @project = Project.find(params[:project_id])
      @bug = @project.bugs.find(params[:id])
   end

  def new
    @bug = @project.bugs.new
   @developers = User.where(user_type: 'developer') 
  end

  def create

    @bug = @project.bugs.new(bug_params)
    @developers = User.where(user_type: 'developer')
    @bug.user = current_user 
    if @bug.save
      redirect_to project_bugs_path(@project, @bug), notice: 'Bug reported successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @developers = User.where(user_type: 'developer')
  end

  def update
    @developers = User.where(user_type: 'developer')

    if @bug.update(bug_params)
      redirect_to project_bug_path(@bug.project, @bug), notice: 'Bug updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bug.destroy
    redirect_to project_bugs_path(@project), notice: 'Bug deleted successfully.'
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_status_params
    params.require(:bug).permit(:status) # Only permit status change
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def find_bug
    @bug = @project.bugs.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :description, :category, :status, :developer_id, :deadline, :screenshot)
  end
end
