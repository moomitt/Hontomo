class Admin::CommentsController < ApplicationController
  def search
    #コメント本文をキーワード検索
    @all_comments = Comment.where('text LIKE(?)', "%#{params[:keyword]}%")
    @comments = @all_comments.page(params[:page]).per(10)
  end

  #コメント一覧画面でのコメント削除
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    #管理者トップ（コメント一覧）にリダイレクト
    redirect_to admin_root_path
  end

end
