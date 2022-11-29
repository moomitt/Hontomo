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
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render :edit
    end
  end

  #ユーザ別コメント画面
  def comment
    @user = User.find(params[:id])
    @all_comments = Comment.where(user_id: @user.id)
    @comments = @all_comments.page(params[:page]).per(10)
  end

  #ユーザ別コメント画面でのコメント削除
  def user_comment_destroy
    comment = Comment.find(params[:id])
    comment.destroy
    #ユーザ別コメント画面にリダイレクト
    redirect_to admin_user_comment_path(comment.user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
