class Admin::HomesController < ApplicationController
  def top
    @comments = Comment.all
    if params[:keyword]
      redirect_to admin_comments_search_path
    end
  end
end
