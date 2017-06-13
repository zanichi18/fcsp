class SkillUsersController < ApplicationController
  before_action :find_or_create_skill, only: [:create, :update]
  before_action :load_skill_user, only: [:edit, :update, :destroy]

  def index
    @skills = Skill.search(name_cont: params[:search]).result
      .limit Settings.school.per_search
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @skill_user = current_user.skill_users.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @skill_user = current_user.skill_users.build skill_user_params
      .merge! skill: @skill
    if @skill_user.save
      render_js t(".success"), 200
    else
      render json: {errors: @skill_user.errors}
    end
  end

  def destroy
    if @skill_user.destroy
      render_js t(".destroy_success"), 200
    else
      render_js t(".destroy_faild"), 400
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @skill_user.update_attributes skill_user_params.merge! skill: @skill
      render_js t(".success"), 200
    else
      render json: {errors: @skill_user.errors}
    end
  end

  private

  def skill_user_params
    params.require(:skill_user).permit :level
  end

  def find_or_create_skill
    @skill = Skill.find_or_create_by name: params[:skill_user][:skill]
    unless @skill
      flash[:danger] = t ".skill_not_found"
      redirect_to user_path current_user
    end
  end

  def load_skill_user
    return if @skill_user = current_user.skill_users.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to user_path current_user
  end
end
