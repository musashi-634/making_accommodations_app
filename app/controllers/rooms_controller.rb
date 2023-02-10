class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update]

  def index
    @rooms = Room.search_rooms(params[:address], params[:keyword])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params.require(:room).permit(:name, :introduction, :price, :address, :image, :user_id))
    if @room.save
      flash[:notice] = '施設を登録しました'
      redirect_to room_path(@room)
    else
      @room.image = nil if @room.errors[:image]
      flash.now[:alert] = '施設を登録できませんでした'
      render 'new'
    end
  end

  def show
    @reservation = Reservation.new
    @reservation.assign_attributes(Reservation.reservation_params(params)) if params[:reservation]
  end

  def edit; end

  def update
    if @room.update(params.require(:room).permit(:name, :introduction, :price, :address, :image))
      flash[:notice] = '施設情報を更新しました'
      redirect_to room_path(@room)
    else
      @room.image = nil if @room.errors[:image]
      flash.now[:alert] = '施設情報を更新できませんでした'
      render 'edit'
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
