class Admin::HomesController < ApplicationController
  def top
    @all_comments = Comment.all
    @comments = @all_comments.page(params[:page]).per(10)
    if params[:keyword]
      redirect_to admin_comments_search_path
    end
  end
end
