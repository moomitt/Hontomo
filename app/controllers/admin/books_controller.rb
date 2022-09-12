class Admin::BooksController < ApplicationController
  def index
    @books = Book.all
    if params[:keyword]
      redirect_to admin_books_search_path
    end
  end
  
  def search
    @books = Book.where('name LIKE(?)', "%#{params[:keyword]}%").or(Book.where('author LIKE(?)', "%#{params[:keyword]}%"))
  end

  def show
    @book = Book.find(params[:id])
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    @comments = Comment.where(book_id: @book.id).sort{|a,b| b.goods.size <=> a.goods.size}
  end

  def edit
    @book = Book.find(params[:id])
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    if params[:tag]
      Tag.create(name: params[:tag])
      redirect_to edit_admin_book_path(@book.id)
    end
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to admin_book_path(book.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:user_id, :name, :author, :series, :isbn, tag_ids: [])
  end
end
