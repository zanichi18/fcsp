class FriendShipsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user

  def create
    current_user.friend_request @user
    current_user.send_email_request_friend @user
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

  def update
    if params[:status] == Settings.friend_ship.accept
      render_json_accept
    else
      render_json_decline
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".not_found"
      redirect_to root_url
    end
  end

  def render_json message, status
    respond_to do |format|
      format.json{render json: {flash: message, status: status}}
    end
  end

  def render_json_accept
    respond_to do |format|
      if current_user.accept_request @user
        format.json{render json: {message: t(".success")}}
      else
        format.json{render json: {message: t(".failed")}}
      end
    end
  end

  def render_json_decline
    respond_to do |format|
      if current_user.decline_request @user
        format.json{render json: {message: t(".reject_success")}}
      else
        format.json{render json: {message: t(".reject_failed")}}
      end
    end
  end
end
