class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    status_text = @user.is_deleted ? "退会" : "有効"
    flash[:notice] = "会員ステータスを#{status_text}に変更しました"
    redirect_to edit_admin_user_path(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end
  
end
