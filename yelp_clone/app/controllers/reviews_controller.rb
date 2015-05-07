class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params)
    redirect_to restaurants_path
  end

  def destroy
    p params
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
