module FriendRequestsHelper
  def suggest_by_mutual_friend users
    array_user = Array.new
    users.reject{|user| user == current_user}.each do |user|
      array_user << user if current_user.mutual_friends(user).present?
    end
    array_user
  end
end
