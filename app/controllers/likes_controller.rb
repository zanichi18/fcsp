class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_post, only: [:create, :destroy]
  before_action :load_like, only: :destroy

  def create
    @like = @post.likes.create user_id: current_user.id
    if @like.save
      load_user_post
      respond_to do |format|
        format.js
      end
    else
      redirect_to user_post_path params[:user_post_id]
    end
  end

  def destroy
    if @like.destroy
      load_user_post
      respond_to do |format|
        format.js
      end
    else
      redirect_to user_post_path params[:user_post_id]
    end
  end

  private
  def load_user_post
    return if @post = Post.find_by(id: params[:user_post_id])
    flash[:danger] = t ".not_found"
    redirect_to user_post_path params[:user_post_id]
  end

  def load_like
    return if @like = current_user.likes.find_by(post_id: params[:user_post_id])
    flash[:danger] = t ".not_found"
    redirect_to user_post_path params[:user_post_id]
  end
end
