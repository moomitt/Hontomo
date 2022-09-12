class Admin::BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
