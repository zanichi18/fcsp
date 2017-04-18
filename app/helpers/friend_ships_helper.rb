module FriendShipsHelper
  def btn_request user
    if current_user.friends_with? user
      link_to "#",
        class: " btn btn-default btn-sm tip btn-responsive unfriend" do
        content_tag(:span, "",
          class: "glyphicon glyphicon-minus") + t(".unfriend")
      end
    elsif current_user.pending_friends.include? user
      link_to "#",
        class: " btn btn-default btn-sm tip btn-responsive remove-request" do
        content_tag(:span, "",
          class: "glyphicon glyphicon-remove") + t(".remove_request")
      end
    else
      link_to "#",
        class: "btn btn-default btn-sm tip btn-responsive request-friend" do
        content_tag(:span, "",
          class: "glyphicon glyphicon-plus") + t(".request_friend")
      end
    end
  end
end
