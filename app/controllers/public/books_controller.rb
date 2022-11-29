class Public::BooksController < ApplicationController
  def index
    @all_books = Book.all
    @books = @all_books.page(params[:page]).per(8)
    #キーワードを受け取ると、検索画面に遷移
    if params[:keyword]
      redirect_to books_search_path
    end
    #タグを受け取ると、検索画面に遷移
    if params[:tag_ids]
      redirect_to books_search_path
    end
  end

  def search
    #キーワード検索
    if params[:keyword]
      #タイトルに部分一致 or 作者名に部分一致
      @all_books = Book.where('name LIKE(?)', "%#{params[:keyword]}%")
      .or(Book.where('author LIKE(?)', "%#{params[:keyword]}%"))
      @books = @all_books.page(params[:page]).per(8)
    end
    #タグ検索
    if params[:tag_ids]
      @tags = []
      @all_books = []
      params[:tag_ids].each do |key,value|
        @tags += Tag.where(name: key) if value == "1"
        @all_books += Tag.find_by(name: key).books if value == "1"
      end
      @tags.uniq!
      @all_books.uniq!
      @books = Kaminari.paginate_array(@all_books).page(params[:page]).per(8)
    end
  end

  #新規登録用の検索画面
  def find
    #キーワード検索
    if params[:keyword]
      keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
      keywords.each do |keyword|
        @items = RakutenWebService::Books::Book.search(title: keyword)
      end
    end
  end

  #新規登録用の確認画面
  def new
    @book = Book.new
    #ISBNコードで検索、1件目を表示
    items = RakutenWebService::Books::Book.search(isbn: params[:isbn])
    @item = items.first
  end

  def create
    @book = Book.new(book_params)
    #ISBNコードで検索、1件目を表示
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
    #ISBNコードで検索、1件目を表示
    items = RakutenWebService::Books::Book.search(isbn: @book.isbn)
    @item = items.first
    #いいね順表示：commentsテーブルとgoodsテーブルを結合、同じcomment_idでグループ化、comment_idの多い順に並べ替え
    @good_comments = @book.comments.left_joins(:goods).group(:id).order('count(goods.comment_id) desc')
    #新着順表示：comment_idの降順に並べ替え
    @new_comments = Comment.where(book_id: @book.id).order('id DESC')
    #ログイン済みの場合のみ、current_userのコメントを表示
    if user_signed_in?
      @user_comments = Comment.where(book_id: @book.id, user_id: current_user.id)
    end
  end

  def search_comment
    @book = Book.find(params[:id])
    #コメント本文をキーワード検索、結果をいいね順に表示
    @search_comments = Comment.where(book_id: @book.id).where('text LIKE(?)', "%#{params[:keyword]}%")
    .sort{|a,b| b.goods.size <=> a.goods.size}
  end

  def edit
    @book = Book.find(params[:id])
    #タグ追加処理
    if params[:tag]
      if @tag = Tag.create(name: params[:tag])
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
