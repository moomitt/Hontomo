class Public::BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def find
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  def new
    @books =  RakutenWebService::Books::Book.search(isbn: params[:isbn])
    @book = Book.new
  end

  def create
    @books =  RakutenWebService::Books::Book.search(isbn: params[:isbn])
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
    @book = Book.find(params[:id])
    if params[:tag]
      Tag.create(name: params[:tag])
      redirect_to edit_book_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id)
  end

  def search
  end
  
  
  private
  def book_params
    params.require(:book).permit(:user_id, :name, :author, :series, :isbn, tag_ids: [])
  end
end
