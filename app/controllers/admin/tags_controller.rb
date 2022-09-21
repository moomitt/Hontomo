class Admin::TagsController < ApplicationController
  def index
    @all_tags = Tag.all
    @tags = @all_tags.page(params[:page]).per(10)
    if params[:tag]
      Tag.create(name: params[:tag])
      redirect_to admin_tags_path
    end
  end
  
  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to admin_tags_path
  end
  
end
