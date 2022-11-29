class Public::GoodsController < ApplicationController

  #非同期通信で処理
  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.find(params[:comment_id])
    good = Good.new
    good.user_id = current_user.id
    good.comment_id = @comment.id
    good.save
  end

  #非同期通信で処理
  def destroy
    @book = Book.find(params[:book_id])
    @comment = Comment.find(params[:comment_id])
    good = current_user.goods.find_by(comment_id: @comment.id)
    good.destroy
  end

end
