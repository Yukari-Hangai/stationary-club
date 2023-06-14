class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def index
    @user = User.find(params[:user_id])
    @current_user_posts = Post.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    @user_posts = Post.where(user_id: @user.id).includes(:user).order("created_at DESC")
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to user_posts_path(current_user)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(current_user)
  end

  def my_page
    @follower_posts = Post.where(user_id: [*current_user.following_ids])
    @post_comment = PostComment.new
  end

  private

  def post_params
    params.require(:post).permit(:text, :image, :user_id)
  end

end
