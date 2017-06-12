class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_requests = current_user.requested_friends.includes :avatar
    @users = User.newest
  end
end
