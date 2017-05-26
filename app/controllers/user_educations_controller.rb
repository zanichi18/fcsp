class UserEducationsController < ApplicationController
  before_action :find_or_create_school, only: [:create, :update]
  before_action :find_user_education, only: [:edit, :update, :destroy]

  def index
    @schools = School.search(name_cont: params[:search]).result
      .limit Settings.school.per_search
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @user_education = current_user.user_educations.build
    render_to_js
  end

  def create
    user_education = current_user.user_educations.build user_education_params
      .merge!(school: @school)
    if user_education.save
      render_to_js t(".success"), 200
    else
      render json: {errors: user_education.errors}
    end
  end

  def edit
    render_to_js
  end

  def update
    if @user_education.update_attributes user_education_params
        .merge!(school: @school)
      render_to_js t(".success"), 200
    else
      render json: {errors: @user_education.errors}
    end
  end

  def destroy
    if @user_education.destroy
      render_to_js t(".success"), 200
    else
      render_to_js t(".fail"), 400
    end
  end

  private

  def user_education_params
    params[:user_education][:graduation] = convert_graduation_to_date
    params.require(:user_education)
      .permit(:school, :major, :graduation, :description)
  end

  def convert_graduation_to_date
    params[:user_education][:graduation].to_date
  rescue
    nil
  end

  def find_or_create_school
    @school = School.find_or_create_by name: params[:user_education][:school]
    unless @school
      flash[:danger] = t ".school_not_found"
      redirect_to user_path current_user
    end
  end

  def render_to_js message = nil, status = nil
    @flash = Supports::FlashValue.new(message, status)
  end

  def find_user_education
    return if @user_education = current_user.user_educations
        .find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to user_path current_user
  end
end
