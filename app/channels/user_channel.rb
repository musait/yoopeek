class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user.id

    # or
    # stream_from "room_#{params[:room]}"
  end
end
