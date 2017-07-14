class ReviewsController < ApplicationController
  before_action :only => [:destroy] do
   redirect_to new_user_session_path unless current_user && current_user.admin
  end

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review created."
      respond_to do |format|
        format.html { redirect_to product_path(@product) }
        format.js
      end
    else
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    Review.find(params[:id]).destroy
    flash[:notice] = "Review deleted."
    redirect_to product_path(@product)
  end

private
  def review_params
    params.require(:review).permit(:author, :content)
  end
end
