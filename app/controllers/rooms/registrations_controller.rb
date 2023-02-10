class Rooms::RegistrationsController < ApplicationController
  def index
    @my_rooms = current_user.registered_rooms
  end
end
