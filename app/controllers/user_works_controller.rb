class UserWorksController < ApplicationController
  before_action :find_or_create_org, only: [:create, :update]
  before_action :load_user_work, only: [:edit, :update, :destroy]

  def index
    @orgs = Organization.search(name_cont: params[:search]).result
  end

  def new
    @user_work = current_user.user_works.build
    respond_to do |format|
      format.js
    end
  end

  def create
    user_work = @org.user_works.new user_work_params
    if user_work.save
      render_js t(".create_success"), 200
    else
      render json: {errors: user_work.errors}
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @user_work.update_attributes update_user_work_params
      render_js t(".update_success"), 200
    else
      render json: {errors: @user_work.errors}
    end
  end

  def destroy
    if @user_work.destroy
      render_js t(".destroy_success"), 200
    else
      render_js t(".destroy_faild"), 400
    end
  end

  private

  def load_user_work
    return if @user_work = UserWork.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def user_work_params
    modified_params
    params.require(:user_work).permit(:position, :start_time,
      :end_time, :status, :description).merge!(user: current_user)
  end

  def update_user_work_params
    modified_params
    params.require(:user_work).permit(:position, :start_time,
      :end_time, :status, :description).merge!(organization: @org)
  end

  def find_or_create_org
    @org = Organization.find_or_create_by name:
      params[:user_work][:organization]
    unless @org
      flash[:danger] = t ".org_not_found"
      redirect_to root_path
    end
  end

  def modified_params
    start_time = params[:user_work][:start_time]
    params[:user_work][:start_time] = convert_string_to_date start_time
    end_time = params[:user_work][:end_time]
    params[:user_work][:end_time] = convert_string_to_date end_time
  end
end
