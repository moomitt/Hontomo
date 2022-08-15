class Public::BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    if params[:tag]
      Tag.create(name: params[:tag])
      redirect_to new_book_path
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
  end

  def update
  end

  def search
  end
  
  private
  def book_params
    params.require(:book).permit(:user_id, :name, :author, :series, tag_ids: [])
  end
end
