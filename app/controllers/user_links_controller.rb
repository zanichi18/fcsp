class UserLinksController < ApplicationController
  before_action :find_user_link, only: [:edit, :update, :destroy]

  def new
    @user_link = current_user.user_links.build
    render_to_js
  end

  def create
    @user_link = current_user.user_links.build user_link_params
    if @user_link.save
      render_to_js t(".success"), 200
    else
      render json: {errors: @user_link.errors}
    end
  end

  def edit
    render_to_js
  end

  def update
    if @user_link.update_attributes user_link_params
      render_to_js t(".success"), 200
    else
      render json: {errors: @user_link.errors}
    end
  end

  def destroy
    if @user_link.destroy
      render_to_js t(".success"), 200
    else
      render_to_js t(".fail"), 400
    end
  end

  private

  def render_to_js message = nil, status = nil
    @flash = Supports::FlashValue.new(message, status)
  end

  def user_link_params
    params.require(:user_link).permit :link
  end

  def find_user_link
    return if @user_link = current_user.user_links.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to user_path current_user
  end
end
