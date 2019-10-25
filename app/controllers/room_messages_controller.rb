class RoomMessagesController < ApplicationController
  before_action :load_entities

  def create
    @room_message = RoomMessage.create(room_message_params)
    RoomChannel.broadcast_to @room, @room_message.attributes.merge!(author_avatar: @room_message.author.avatar_url)
    render json: { status: :true }
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end

  def room_message_params
    params.require(:room_message).permit(:message, :receiver_id,:author_id,:room_id)
  end
end
