class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to users_mypage_path 
  end

  def confirm
  end

  def withdraw
    user = current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
