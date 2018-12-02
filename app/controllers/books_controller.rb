class BooksController < ApplicationController
  before_action :find_user, only: [:like, :dislike]
  def index
    @books = Book.all.page params[:page]
  end

  def show
    @book = Book.find(params[:id])
  end

  def like
    @user.like(book)
  end

  def dislike
    @user.dislike(book)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end


end
