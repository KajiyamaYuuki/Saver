class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @shop = Shop.find(params[:shop_id])
    @reviews = @shop.reviews
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to shop_reviews_path(@review.shop)
    else
      flash.now[:alert] = "レビューの投稿に失敗しました"
      @shop = Shop.find(params[:shop_id])
      render 'shops/show'
    end
  end

  private
  def review_params
    params.require(:review).permit(:shop_id, :content, :score)
  end

end
