class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find params[:room_id]
    stream_for room

    # or
    # stream_from "room_#{params[:room]}"
  end
end
