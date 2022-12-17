class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path
    else
      render :edit
    end
  end

  def confirm
  end

  # 退会処理
  def withdraw
    user = current_user
    user.update(is_deleted: true)
    # 退会処理後、ログアウト→トップページにリダイレクト
    reset_session
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
