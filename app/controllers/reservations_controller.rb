class ReservationsController < ApplicationController
  def index
    @my_reservations = current_user.reservations
  end

  def create
    @reservation = Reservation.new(Reservation.reservation_params(params))
    if @reservation.save
      flash[:notice] = '施設を予約しました'
      redirect_to reservations_path
    else
      flash.now[:alert] = '施設を予約できませんでした'
      render 'rooms/show'
    end
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = Reservation.new(Reservation.reservation_params(params))

    return if @reservation.valid?

    flash.now[:alert] = '予約内容に誤りがあります'
    render 'rooms/show'
  end
end
