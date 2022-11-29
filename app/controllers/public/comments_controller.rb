class Public::CommentsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @comment = Comment.new
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end
  
  #ユーザのコメント削除はbooks/showページのみ
  def destroy
    @book = Book.find(params[:book_id])
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      #booshowページにリダイレクト
      redirect_to book_path(@book.id)
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:user_id, :book_id, :text)
  end
end
