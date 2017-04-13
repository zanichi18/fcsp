class FriendShipsController < ApplicationController
  before_action :load_user

  def create
    current_user.friend_request @user
    render_json t(".request_friend", name: @user.name), 200
  end

  def destroy
    if params[:is_unfriend].present?
      current_user.remove_friend @user
      render_json t(".unfriend", name: @user.name), 200
    else
      current_user.decline_request @user
      render_json t(".remove_request", name: @user.name), 200
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    render_json t(".not_found"), 404 unless @user
  end

  def render_json message, status
    respond_to do |format|
      format.json{render json: {flash: message, status: status}}
    end
  end
end
