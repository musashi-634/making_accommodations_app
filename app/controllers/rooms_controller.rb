class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update]

  def index
    @rooms = Room.where('address LIKE ?', "%#{params[:address]}%")
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

  def show; end

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
