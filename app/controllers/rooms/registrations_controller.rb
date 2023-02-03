class Rooms::RegistrationsController < ApplicationController
  def index
    @my_rooms = current_user.rooms
  end
end
