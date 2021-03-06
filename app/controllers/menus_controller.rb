class MenusController < ApplicationController
  before_action :ensure_shop_owner, only: %i[ new create edit update destroy ]
  before_action :set_menu, only: %i[ edit update destroy ]
  before_action :ensure_my_shop_owner, only: %i[ edit update destroy ]

  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = current_user.shop.menus.build(menu_params)
    if @menu.save
      redirect_to shop_path(current_user.shop.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      redirect_to shop_path(current_user.shop.id)
    else
      render :edit
    end
  end

  def destroy
    @menu.destroy
    redirect_to shop_path(current_user.shop.id)
  end

  private
  def menu_params
    params.require(:menu).permit(:title, :description, :image, :price, :interval_hour, :reservationable)
  end

  def ensure_my_shop_owner
    if current_user.present?
      unless current_user.id == @menu.shop.user_id
        flash[:notice] = '権限がありません'
        redirect_to shops_path
      end
    else
      flash[:notice] = '権限がありません'
      redirect_to shops_path
    end
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end

end
