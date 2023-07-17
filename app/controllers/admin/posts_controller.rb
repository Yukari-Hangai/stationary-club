class Admin::PostsController < ApplicationController
  before_action :authenticate_admin! 
  
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.where(user_id: @user.id).includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_user_posts_path(@post.user_id)
  end
  
end
