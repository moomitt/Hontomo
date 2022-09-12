class Admin::BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    @comments = Comment.where(book_id: @book.id).sort{|a,b| b.goods.size <=> a.goods.size}
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
