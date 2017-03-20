class Education::PostsController < Education::BaseController
  def index
    @posts = Education::Post.created_desc.includes(:images, :user, :category)
      .page(params[:page]).per Settings.education.posts.per_page
  end
end
