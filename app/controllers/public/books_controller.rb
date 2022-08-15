class Public::BooksController < ApplicationController
  def index
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
  end

  def edit
  end

  def update
  end

  def search
  end
  
  private
  def book_params
    params.require(:book).permit(:user_id, :title, :author, :series)
  end
end
