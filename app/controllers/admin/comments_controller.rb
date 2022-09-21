class Admin::CommentsController < ApplicationController
  def search
    @all_comments = Comment.where('text LIKE(?)', "%#{params[:keyword]}%")
    @comments = @all_comments.page(params[:page]).per(10)
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_root_path
  end

end
