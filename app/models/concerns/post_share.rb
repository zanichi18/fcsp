module PostShare
  def share_post user
    share_posts.build user_id: user.id
  end

  def unshare_post user
    unshare = share_posts.find_by user_id: user.id
    unshare.destroy if unshare
  end
end
