class Public::CommentsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @comment = Comment.new
  end

  def create
    book = Book.find(params[:book_id])
    comment = Comment.new(comment_params)
    comment.book_id = book.id
    comment.user_id = current_user.id
    comment.save
    redirect_to book_path(book.id)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
