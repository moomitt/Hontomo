class Admin::CommentsController < ApplicationController
  def search
    @comments = Comment.where('text LIKE(?)', "%#{params[:keyword]}%")
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_root_path
  end

end
