module PostsHelper
  def shared_post? post
    @shared_post_ids.include? post.id if @shared_post_ids.present?
  end

  def check_type_share? object
    object.shareable_type == Settings.share_type
  end
end
