module FriendShipsHelper
  def btn_request user
    if current_user.pending_friends.include? user
      btn_pending_friend user
    elsif current_user.requested_friends.include? user
      btn_requested_friend user
    elsif current_user.friends_with? user
      btn_is_friend user
    else
      link_to "#",
        class: "btn btn-default btn-sm tip btn-responsive request-friend",
        data: {id: user.id} do
        content_tag(:span, "",
          class: "glyphicon glyphicon-plus") + t(".request_friend")
      end
    end
  end

  def btn_is_friend user
    link_to "#",
      class: "btn btn-default btn-sm tip btn-responsive unfriend",
      data: {id: user.id} do
      content_tag(:span, "",
        class: "glyphicon glyphicon-minus") + t(".unfriend")
    end
  end

  def btn_pending_friend user
    link_to "#",
      class: "btn btn-default btn-sm tip btn-responsive remove-request",
      data: {id: user.id} do
      content_tag(:span, "",
        class: "glyphicon glyphicon-remove") + t(".remove_request")
    end
  end

  def btn_requested_friend user
    link_to "#",
      class: "btn btn-default btn-sm tip btn-responsive request-waiting",
      data: {id: user.id} do
      content_tag(:span, "",
        class: "glyphicon glyphicon-ok") + t(".waiting")
    end
  end
end
