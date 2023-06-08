class HomesController < ApplicationController
  
  def top
    
  end
  
  #退会する会員を検索
  def quit
    @user = User.find_by(name: params[:name])
  end
  
  #退会処理
  def out
    @user = User.find_by(name: params[:name])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
end
