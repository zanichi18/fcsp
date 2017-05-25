class UserLanguagesController < ApplicationController
  before_action :find_or_create_language, only: [:create, :update]
  before_action :load_user_language, only: [:edit, :update, :destroy]

  def index
    @languages = Language.search(name_cont: params[:search]).result
  end

  def new
    @user_language = current_user.user_languages.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @user_language = @language.user_languages.new user_language_params
    if @user_language.save
      render_js t(".create_success"), 200
    else
      render json: {errors: @user_language.errors}
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @user_language.update_attributes user_language_update_params
      render_js t(".update_success"), 200
    else
      render json: {errors: @user_language.errors}
    end
  end

  def destroy
    if @user_language.destroy
      render_js t(".destroy_success"), 200
    else
      render_js t(".destroy_failed"), 400
    end
  end

  private

  def find_or_create_language
    @language = Language.find_or_create_by name:
      params[:user_language][:language]
    unless @language
      flash[:danger] = t ".language_not_found"
      redirect_to root_path
    end
  end

  def user_language_params
    params.require(:user_language).permit(:level)
      .merge! user: current_user
  end

  def user_language_update_params
    params.require(:user_language).permit(:level)
      .merge! language: @language
  end

  def load_user_language
    return if @user_language = UserLanguage.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
