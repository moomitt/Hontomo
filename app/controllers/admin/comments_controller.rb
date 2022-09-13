class Admin::CommentsController < ApplicationController
  def search
    @comments = Comment.where('text LIKE(?)', "%#{params[:keyword]}%")
  end
  
  def destroy
  end
end
