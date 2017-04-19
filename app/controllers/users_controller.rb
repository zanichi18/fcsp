class UsersController < ApplicationController
  before_action :find_user, only: :show

  def show
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    if @user
      if @user.education_status_blocked?
        flash[:danger] = t ".blocked"
        redirect_to root_url
      end
    else
      flash[:danger] = t ".not_found"
      redirect_to root_url
    end
  end
end
