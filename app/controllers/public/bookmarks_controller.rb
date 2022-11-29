class Public::BookmarksController < ApplicationController
  #ログインしていない場合、ログインページにリダイレクト
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    bookmark = @book.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      #遷移元のURLを取得してリダイレクト
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    bookmark = @book.bookmarks.find_by(user_id: current_user.id)
    #二度押しのエラー回避
    if bookmark.present?
      bookmark.destroy
      #遷移元のURLを取得してリダイレクト
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end
end
