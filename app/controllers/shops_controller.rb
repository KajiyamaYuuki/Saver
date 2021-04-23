class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]
  before_action :ensure_shop_owner, only: %i[ new create edit update destroy ]
  before_action :ensure_my_shop_owner, only: %i[ edit update destroy ]

  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = current_user.build_shop(shop_params)
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
    params.require(:shop).permit(:name, :description, :post_code, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :email, :url, :image)
  end

  def ensure_my_shop_owner
    if current_user.present?
      unless current_user.id == @shop.user_id
        flash[:notice] = '権限がありません'
        redirect_to shops_path
      end
    else
      flash[:notice] = '権限がありません'
      redirect_to shops_path
    end
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

end
