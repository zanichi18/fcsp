class InfoUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_info_user, only: :update

  def update
    if @info_user.update_attributes info_user_params
      respond_to do |format|
        format.js
      end
    else
      render json: {errors: @info_user.errors}
    end
  end

  private

  def info_user_params
    params.require(:info_user).permit :introduce, :ambition, :quote, :address,
      :phone
  end

  def find_info_user
    @info_user = InfoUser.includes(:user).find_by id: params[:id]
    unless @info_user
      flash[:danger] = t ".infor_user_not_found"
      redirect_to root_url
    end
  end
end
