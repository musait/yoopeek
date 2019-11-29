class RoomsController < ApplicationController
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  before_action :load_entities

  def index
    @rooms = Room.where("receiver_id = ? OR author_id = ?", current_user.id,current_user.id).order(:created_at => :desc)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new permitted_parameters
    if @room.save
      redirect_to @room
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      redirect_to @room
    else
      render @room
    end
  end

  def show
    @room_message = RoomMessage.new room: @room
    @room = Room.includes(:room_messages => [:author => :avatar_attachment]).find(params[:id]) if params[:id]
    @room_messages = @room.room_messages.valid_messages
    Notification.set_seen @notification_messages, "room_message", @room_messages.ids
    count_notification
  end

  protected

  def load_entities
    @rooms = Room.where("receiver_id = ? OR author_id = ?", current_user.id,current_user.id)
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name,:author_id, :receiver_id, :job_id)
  end
end
