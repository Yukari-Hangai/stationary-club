class SearchesController < ApplicationController
#before_action :authenticate_user!, :authenticate_admin!
  def search
    @word = params[:word]
    @range = params[:range]
    if @range == "会員"
      @users = User.looks(params[:search], params[:word]).page(params[:page])
    else
      @posts = Post.looks(params[:search], params[:word])
      @user = @posts.pluck(:user_id)
      @post_comment = PostComment.new
    end
  end
end
