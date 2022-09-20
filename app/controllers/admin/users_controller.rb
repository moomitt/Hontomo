class Admin::UsersController < ApplicationController
  def index
    @all_users = User.all
    @users = @all_users.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_user_path(user.id)
  end

  def comment
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
  end
  
  def user_comment_destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_user_comment_path(comment.user.id)
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
