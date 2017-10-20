class ProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :destroy, :update]
  before_action :get_users, only: [:new, :edit, :create]

  def index
    if current_user.has_role RoleConstant::MANAGER
      @projects = Project.newest_first
    else
      @projects = current_user.projects.newest_first
    end
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
			if @project.save
				flash[:success]= "Project was successfully created."
				format.html { redirect_to projects_url}
			else
				flash[:error] =  'Project can not be created.'
				format.html { render :new  }
			end
		end
  end

  def update
    respond_to do |format|
			if @project.update(project_params)
				flash[:success]= "Project was successfully updated."
				format.html { redirect_to projects_url}
			else
				flash[:error] = 'Project can not be updated.'
				format.html { render :edit  }
			end
		end
  end

  def destroy
    @project.destroy
    respond_to do |format|
    	flash[:notice]= 'Project was successfully destroyed.'
      format.html { redirect_to projects_url }
    end
	end


  private

	def project_params
		params.require(:project).permit(:title, :description, :user_ids => [])
	end

  def set_project
    @project = Project.find(params[:id])
  end

  def get_users
    @users = User.all
  end

end
