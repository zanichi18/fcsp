class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    @user.build_info_user if @user.info_user.nil?
  end

  def update
    if @user.update params.require(:user)
        .permit info_user_attributes: [:introduce]
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".not_found"
      redirect_to root_url
    end
  end
end
