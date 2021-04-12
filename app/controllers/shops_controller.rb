class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]

  def index
    @shops = Shop.all
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to shop_path(@shop.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to shop_path(@shop.id)
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    redirect_to user_path(current_user.id)
  end

  private
  def shop_params
    params.require(:shop).permit(:name, :description, :post_code, :address, :phone_number, :email, :url, :image)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
