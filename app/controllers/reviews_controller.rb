class ReviewsController < ApplicationController
  def index
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to book_path(@review.book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :book_id, :content)
  end
end
