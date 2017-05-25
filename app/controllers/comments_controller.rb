class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: [:new, :edit, :create, :destroy]
  before_action :load_comment, only: [:destroy, :update, :edit]

  def create
    @comment = @post.comments.build comment_params
    if @comment.save
      get_list_comment
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".create_failed"
      respond_to user_post_path params[:user_post_id]
    end
  end

  def destroy
    if @comment.destroy
      load_post
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".destroy_failed"
      respond_to user_post_path params[:user_post_id]
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      get_list_comment
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".update_failed"
      respond_to user_post_path params[:user_post_id]
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :user_id
  end

  def load_post
    @post = Post.find_by id: params[:user_post_id]
    unless @post
      flash[:error] = t ".not_found"
      redirect_to user_post_path params[:user_post_id]
    end
  end

  def load_comment
    return if @comment = current_user.comments.find_by(id: params[:id])
    flash[:error] = t ".not_found"
    redirect_to user_post_path params[:user_post_id]
  end

  def get_list_comment
    load_post
    @comments = @post.comments.newest
  end
end
