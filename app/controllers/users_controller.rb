class UsersController < ApplicationController
  before_action :find_user, only: :show

  private

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".not_found"
      redirect_to root_url
    end
  end
end
