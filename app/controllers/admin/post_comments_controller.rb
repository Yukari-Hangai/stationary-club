class Admin::PostCommentsController < ApplicationController

  def destroy
    PostComment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
  end
  
end
