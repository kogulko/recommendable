class BooksController < ApplicationController
  before_action :find_user, only: [:like, :dislike, :recomendations]
  before_action :find_book, only: [:show, :like, :dislike]

  def index
    @books = Book.all.page params[:page]
    @title = 'Featured Books'
  end

  def best
    @books = Kaminari.paginate_array(Book.top(100)).page(params[:page]).per(8)
    @title = 'TOP Books'
    render 'index'
  end

  def recomendations
    @books = Kaminari.paginate_array(@user.recommended_books).page(params[:page]).per(8)
    @title = 'Recommended Books'
    render 'index'
  end

  def show
    @in_top = Book.top(100).include?(@book)
  end

  def like
    @user.like(@book)
    redirect_to book_path(@book)
  end

  def dislike
    @user.dislike(@book)
    redirect_to book_path(@book)
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_book
    @book = Book.find(params[:id])
  end


end
