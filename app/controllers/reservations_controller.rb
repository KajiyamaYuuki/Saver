class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      redirect_to reservations_path
    else
      render :new
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:start_scheduled_at, :end_scheduled_at, menu_id: params[:menu_id])
  end

end
