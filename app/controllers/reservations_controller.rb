class ReservationsController < ApplicationController
  def index
    @my_reservations = current_user.reservations
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(Reservation.reservation_params(params))

    render 'rooms/show' and return if params[:back] || !@reservation.save

    flash[:notice] = '施設を予約しました'
    redirect_to reservations_path
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(Reservation.reservation_params(params))

    return if @reservation.valid?

    flash.now[:alert] = '予約内容に誤りがあります'
    render 'rooms/show'
  end
end
