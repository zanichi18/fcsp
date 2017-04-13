module FriendShipsHelper
  def btn_request user
    if current_user.friends_with? user
      link_to t(".unfriend"), "#",
        class: "btn btn-danger btn-follow unfriend"
    elsif current_user.pending_friends.include? user
      link_to t(".remove_request"), "#",
        class: "btn btn-warning btn-follow remove-request"
    else
      link_to t(".request_friend"), "#",
        class: "btn btn-success btn-follow request-friend"
    end
  end
end
