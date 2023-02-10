class Reservations::ConfirmationsController < ApplicationController
  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(Reservation.reservation_params(params))

    return if @reservation.valid?

    flash.now[:alert] = '予約内容に誤りがあります'
    render 'rooms/show'
  end
end
