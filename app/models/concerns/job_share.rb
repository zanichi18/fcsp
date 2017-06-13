module JobShare
  def share user
    shares.build user_id: user.id
  end

  def unshare user
    unshare = shares.find_by user_id: user.id
    unshare.destroy if unshare
  end
end
