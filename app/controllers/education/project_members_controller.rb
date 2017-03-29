class Education::ProjectMembersController < Education::BaseController
  before_action :load_project
  before_action :load_project_member, only: :destroy
  load_and_authorize_resource

  def create
    if params[:users].present?
      users = params[:users]
      Education::ProjectMember.transaction do
        users.each do |id, value|
          project_member = @project.members
            .new user_id: id, position: value.to_i
          project_member.save!
        end
        render_js
      end
    else
      redirect_to @project
    end
  end

  def destroy
    if @project_member.destroy
      render_js
    else
      flash[:warning] = t ".delete_fail"
      redirect_to @project
    end
  end

  private

  def load_project
    @project = Education::Project.find_by id: params[:project_id]
    unless @project
      flash[:danger] = t ".not_found"
      redirect_to education_root_path
    end
  end

  def load_project_member
    @project_member = @project.members.find_by user_id: params[:user_id]
    unless @project_member
      flash[:danger] = t ".not_found"
      redirect_to education_projects_path
    end
  end

  def render_js
    @users = User.not_in_object @project
    respond_to do |format|
      format.js
    end
  end
end
