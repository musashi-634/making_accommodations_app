class Rooms::RegistrationsController < ApplicationController
  def index
    @my_rooms = Room.where(user_id: current_user.id)
  end
end
