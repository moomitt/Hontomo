class Admin::BooksController < ApplicationController
  def index
    @all_books = Book.all
    @books = @all_books.page(params[:page]).per(10)
    if params[:keyword]
      redirect_to admin_books_search_path
    end
  end

  def search
    @all_books = Book.where('name LIKE(?)', "%#{params[:keyword]}%").or(Book.where('author LIKE(?)', "%#{params[:keyword]}%"))
    @books = @all_books.page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    @good_comments = @book.comments.left_joins(:goods).group(:id).order('count(goods.comment_id) desc')
    @new_comments = Comment.where(book_id: @book.id).order('id DESC')
  end

  def search_comment
    @book = Book.find(params[:id])
    @search_comments = Comment.where(book_id: @book.id).where('text LIKE(?)', "%#{params[:keyword]}%").sort{|a,b| b.goods.size <=> a.goods.size}
  end

  def book_comment_destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_book_path(comment.book.id)
  end

  def edit
    @book = Book.find(params[:id])
    if params[:tag]
      if Tag.create(name: params[:tag])
        redirect_to edit_admin_book_path
      else
        render :edit
      end
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to admin_books_path
  end

  private
  def book_params
    params.require(:book).permit(:user_id, :name, :author, :series, :isbn, tag_ids: [])
  end
end
