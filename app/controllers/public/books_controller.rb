class Public::BooksController < ApplicationController
  def index
    @books = Book.all
    if params[:keyword]
      redirect_to books_search_path
    end
    if params[:tag_ids]
      redirect_to books_search_path
    end
  end
  
  def search
    if params[:keyword]
      @books = Book.where('name LIKE(?)', "%#{params[:keyword]}%").or(Book.where('author LIKE(?)', "%#{params[:keyword]}%"))
    end
    if params[:tag_ids]
      @tags = []
      @books = []
      params[:tag_ids].each do |key,value|
        @tags += Tag.where(name: key) if value == "1"
        @books += Tag.find_by(name: key).books if value == "1"
      end
      @tags.uniq!
      @books.uniq!
    end
  end
  
  def find
    if params[:keyword]
      @items = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end
  
  def new
    @book = Book.new
    items = RakutenWebService::Books::Book.search(isbn: params[:isbn])
    @item = items.first
  end

  def create
    @book = Book.new(book_params)
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    @good_comments = Comment.where(book_id: @book.id).sort{|a,b| b.goods.size <=> a.goods.size}
    @new_comments = Comment.where(book_id: @book.id).order('id DESC')
    if user_signed_in?
      @user_comments = Comment.where(book_id: @book.id, user_id: current_user.id)
    end
  end
  
  def search_comment
    @book = Book.find(params[:id])
    @search_comments = Comment.where(book_id: @book.id).where('text LIKE(?)', "%#{params[:keyword]}%").sort{|a,b| b.goods.size <=> a.goods.size}
  end

  def edit
    @book = Book.find(params[:id])
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    if params[:tag]
      if Tag.create(name: params[:tag])
        redirect_to edit_book_path
      else
        render :edit
      end
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  private
  def book_params
    params.require(:book).permit(:user_id, :name, :author, :series, :isbn, tag_ids: [])
  end
end
