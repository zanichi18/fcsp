class Education::PostsController < Education::BaseController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]
  before_action :load_post, only: [:show]
  before_action :load_user_image_object, only: [:new, :edit]
  before_action :load_post_of_user, only: [:update, :destroy, :edit]

  def index
    @posts = Education::Post.created_desc.includes(:user, :category)
      .page(params[:page]).per Settings.education.posts.per_page
  end

  def new
    @post = Education::Post.new
  end

  def create
    @post = current_user.education_posts.build post_params
    if @post.save
      flash[:success] = t ".post_create_success"
      redirect_to @post
    else
      load_user_image_object
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      flash[:success] = t ".post_update_success"
      redirect_to @post
    else
      render :edit
    end
  end

  def show
    @post_object = Supports::Education::ShowPost.new @post
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".post_delete_success"
    else
      flash[:danger] = t ".post_delete_fail"
    end
    redirect_to education_posts_path
  end

  private

  def load_post
    return if @post = Education::Post.find_by(id: params[:id])
    flash[:danger] = t ".post_not_found"
    redirect_to education_posts_path
  end

  def post_params
    params.require(:education_post).permit :title, :cover_photo,
      :content, :category_id, :tag_list
  end

  def load_user_image_object
    @user_image_object = Supports::Education::UserImage.new current_user
  end

  def load_post_of_user
    @post = current_user.education_posts.find_by id: params[:id]
    not_found unless @post
  end
end
