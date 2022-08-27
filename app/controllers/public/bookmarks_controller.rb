class Public::BookmarksController < ApplicationController
  
  before_action :authenticate_user!   #ログインしていない場合、トップページにリダイレクト
  
  def create
    @book = Book.find(params[:book_id])
    bookmark = @book.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer    #遷移元のURLを取得してリダイレクト
    else
      redirect_to request.referer
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    bookmark = @book.bookmarks.new(user_id: current_user.id)
    if bookmark.present?      #二度押しのエラー回避
      bookmark.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
