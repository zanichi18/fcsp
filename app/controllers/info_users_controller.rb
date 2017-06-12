class InfoUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_info_user, only: :update

  def update
    if params[:info_statuses].present?
      if update_info_status @info_user
        respond_to do |format|
          format.json{render json: {flash: t(".success"), status: 200}}
        end
      else
        respond_to do |format|
          format.json{render json: {flash: t(".fail"), status: 400}}
        end
      end
    elsif @info_user.update_attributes info_user_params
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
    @info_user = current_user.info_user
    unless @info_user
      flash[:danger] = t ".infor_user_not_found"
      redirect_to root_url
    end
  end

  def update_info_status info_user
    params[:info_statuses].each do |info, status|
      if InfoUser::INFO_ATTRIBUTES.include?(info.to_sym) &&
        InfoUser::INFO_STATUS.values.include?(status.to_i)
        info_user.info_statuses[info.to_sym] = status.to_i
        info_user.save
      else
        return false
      end
    end
  end
end
