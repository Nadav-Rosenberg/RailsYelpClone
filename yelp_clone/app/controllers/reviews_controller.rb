class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    new_params = review_params.merge( { "user_id" => current_user.id } )

    @review = @restaurant.reviews.new(new_params)
    @review.save
    flash[:notice] = @review.errors[:user_id][0] unless @review.save
    @review.user_id = current_user.id
    redirect_to restaurants_path
  end

  def destroy 
    @review = Review.find(params[:id])
    if current_user.id == @review.user_id
      @review.destroy
      flash[:notice] = 'Review deleted successfully'
      redirect_to "/restaurants/#{params[:restaurant_id]}"
    else
      flash[:notice] = 'Only author can delete review'
      redirect_to "/restaurants/#{params[:restaurant_id]}"
    end  
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
