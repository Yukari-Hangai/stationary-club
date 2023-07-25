class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

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
    @posts = Post.where(user_id: @user.id).includes(:user).order("created_at DESC").page(params[:page]).per(5)
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_posts_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(current_user)
  end

  def my_page
    @follower_posts = Post.where(user_id: [*current_user.following_ids]).page(params[:page]).per(5)
    @post_comment = PostComment.new
  end

  private

  def post_params
    params.require(:post).permit(:text, :image, :user_id)
  end
  
  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to user_posts_path(post.user_id)
    end
  end

end
