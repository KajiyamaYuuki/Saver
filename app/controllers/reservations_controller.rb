class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :set_menu, only: %i[ index new create destroy]
  before_action :ensure_my_shop_owner, only: %i[ index destroy ]

  def index
    @reservations = @menu.reservations
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.menu_id = @menu.id
    if @reservation.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def destroy
    @reservation = @menu.reservations.find(params[:id])
    @reservation.destroy
    @reservations = @menu.reservations
    render :index
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_scheduled_at, :end_scheduled_at)
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def ensure_my_shop_owner
    if current_user.present?
      unless current_user.id == @menu.shop.user_id
        flash[:notice] = '権限がありません'
        redirect_to shop_path(@menu.shop_id)
      end
    else
      flash[:notice] = '権限がありません'
      redirect_to shop_path(@menu.shop_id)
    end
  end
end
