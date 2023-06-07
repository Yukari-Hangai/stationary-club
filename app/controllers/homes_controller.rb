class HomesController < ApplicationController
  #退会処理
  def unsubscribe
    @user = User.find_by(name: params[:name])
  end

end
