class Public::HomesController < ApplicationController
  def top
    @popular_books = Book.find(Comment.group(:book_id).order('count(id) desc').pluck(:book_id))
    @new_books = Book.order('id DESC').limit(4)
  end
  
  #Commentモデルのbook_idが同じものでまとめて
  #それをcomment_idの多い順に並び替えて、book_idを取り出す
  
  def about
  end
end
