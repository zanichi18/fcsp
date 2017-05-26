module LikesHelper
  def liked? post_id
    current_user.likes.find_by post_id: post_id
  end
end
