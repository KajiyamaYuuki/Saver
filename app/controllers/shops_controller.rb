class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]

  def index
    @shops = Shop.all
  end

  def new

  end

  def create

  end

  def show
  end

  def edit
  end


  def update

  end

  def destroy

  end

  private
  def shop_params
    params.require(:shop).permit(:name, :description, :post_code, :address, :phone_number, :email, :url, :image)
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
