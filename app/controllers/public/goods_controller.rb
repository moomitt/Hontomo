class Public::GoodsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = Comment.find(params[:comment_id])
    good = Good.new
    good.user_id = current_user.id
    good.comment_id = comment.id
    good.save
    redirect_to book_path(book.id)
  end
  
  def destroy
    book = Book.find(params[:book_id])
    comment = Comment.find(params[:comment_id])
    good = current_user.goods.find_by(comment_id: comment.id)
    good.destroy
    redirect_to book_path(book.id)
  end
  
end
