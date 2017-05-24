class UserProjectsController < ApplicationController
  before_action :load_user_project, only: [:edit, :update, :destroy]

  def new
    @user_project = current_user.user_projects.build
    respond_to do |format|
      format.js
    end
  end

  def create
    user_project = current_user.user_projects.new user_project_params
    if user_project.save
      render_js t(".create_success"), 200
    else
      render_js t(".create_faild"), 400
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @user_project.update_attributes user_project_params
      render_js t(".update_success"), 200
    else
      render_js t(".update_faild"), 400
    end
  end

  def destroy
    if @user_project.destroy
      render_js t(".destroy_success"), 200
    else
      render_js t(".destroy_faild"), 400
    end
  end

  private

  def render_js message, status
    @message = message
    @status = status
    respond_to do |format|
      format.js
    end
  end

  def load_user_project
    return if @user_project = UserProject.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def user_project_params
    params.require(:user_project).permit :title, :start_date,
      :end_date, :url, :description
  end
end
