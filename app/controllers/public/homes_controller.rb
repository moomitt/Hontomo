class Public::HomesController < ApplicationController
  def top
    #コメント数順表示：
    #同じbook_idのcommentをグループ化、comment_idの多い順に並び替え、上位4件のbook_idを取り出す
    @popular_books = Book.find(Comment.group(:book_id).order('count(id) desc').limit(4).pluck(:book_id))
    #新着順表示：book_idの降順で並び替え、上位4件を表示
    @new_books = Book.order('id DESC').limit(4)
  end

  def about
  end
end
