class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
  end
  
end
