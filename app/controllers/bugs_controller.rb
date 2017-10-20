class BugsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_project, only: [:new, :edit, :create, :show]
  before_action :get_users, only: [:new, :create]

  def index
    if current_user.has_role RoleConstant::DEVELOPER
      @bugs = current_user.bugs.newest_first
    elsif current_user.has_role RoleConstant::QA
      @bugs = current_user.created_bugs.newest_first
    else
      @bugs = Bug.all
    end
  end

  def new
    @bug = Bug.new
  end

  def show
    @bugs = @project.bugs
  end

  def create
    @bug = Bug.new(bug_params)
    respond_to do |format|
      if @bug.save
        flash[:success]= "Project was successfully created."
        format.html { redirect_to projects_url}
      else
        flash[:error] =  'Project can not be created.'
        format.html { render :new  }
      end
    end
  end

  def change_status
    if params[:bug_type] == StatusConstant::FEATURE
      @status = Bug::FEATURE_STATUS
    else
      @status = Bug::BUG_STATUS
    end
    render :partial => "status", :locals =>{:status=> @status}
  end

  def bug_status
    bug = Bug.find(params[:bug_id])
    bug.update_columns(status: params[:status]) if bug
    if request.xhr?
        render :json => {
                            :msg => "updated"
                        }
     end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description, :status, :bug_type, :deadline, :screen_shot, :creator_id, :user_id, :project_id)
  end

  def get_users
    @users = User.all
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
