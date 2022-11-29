class Admin::BooksController < ApplicationController
  def index
    @all_books = Book.all
    @books = @all_books.page(params[:page]).per(10)
    #キーワードを受け取ると、検索画面に遷移
    if params[:keyword]
      redirect_to admin_books_search_path
    end
  end

  def search
    #キーワード検索
    #タイトルに部分一致 or 作者名に部分一致
    @all_books = Book.where('name LIKE(?)', "%#{params[:keyword]}%")
    .or(Book.where('author LIKE(?)', "%#{params[:keyword]}%"))
    @books = @all_books.page(params[:page]).per(10)
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
  end

  def search_comment
    @book = Book.find(params[:id])
    #コメント本文をキーワード検索、結果をいいね順に表示
    @search_comments = Comment.where(book_id: @book.id).where('text LIKE(?)', "%#{params[:keyword]}%")
    .sort{|a,b| b.goods.size <=> a.goods.size}
  end

  #showページでのコメント削除
  def book_comment_destroy
    comment = Comment.find(params[:id])
    comment.destroy
    #showページにリダイレクト
    redirect_to admin_book_path(comment.book.id)
  end

  def edit
    @book = Book.find(params[:id])
    #タグ追加処理
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
