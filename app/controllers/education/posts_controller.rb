class Education::PostsController < Education::BaseController
  before_action :load_post, only: :show

  def index
    @posts = Education::Post.created_desc.includes(:user, :category)
      .page(params[:page]).per Settings.education.posts.per_page
  end

  def show
    @post_object = Supports::Education::ShowPost.new @post
  end

  private

  def load_post
    return if @post = Education::Post.find_by(id: params[:id])
    flash[:danger] = t "education.post.post_not_found"
    redirect_to education_root_path
  end
end
