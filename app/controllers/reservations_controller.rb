class ReservationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @reservations = Reservation.all
  end

  def new
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.new
  end

  def create
    @menu = Menu.find(params[:menu_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.menu_id = @menu.id
    if @reservation.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_scheduled_at, :end_scheduled_at)
  end

end
