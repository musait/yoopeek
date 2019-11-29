class RoomMessagesController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :load_entities

  def create
    if current_user.worker?
      if (@room.room_messages.valid_messages.where(author_id: current_user.id).count > 0) &&CreditChangement.exists?(room_id: @room.id, user_id: current_user.id)
        create_message
      else
        @credits = Rails.application.credentials.dig(:message_price).to_f
        if current_user.pay_with_credits(@credits, "room", @room)
          create_message
        else
          # current_user.refund_credits(credits)
          render js: 'toastr["error"]("' + I18n.t('not_enougth_credits') + '<br /><br /><a href=\"' + buy_credits_path + '\">En acheté ici</a>");'
        end
      end
    else
      create_message
    end

  end

  protected
  def create_message
    @room_message = RoomMessage.create(room_message_params)

    if @room_message.valid? &&@room_message.is_valid
      RoomChannel.broadcast_to @room, @room_message.attributes.merge!(author_avatar: @room_message.author.avatar_url, author_full_name: @room_message.author.full_name, time_ago_in_words: time_ago_in_words(@room_message.created_at))

      receiver =  @room.author.eql?(current_user) ? @room.receiver : @room.author
      sender =  @room.author.eql?(current_user) ? @room.author : @room.receiver
      Notification.create!(message: @room_message.message, room_message: @room_message, created_for: @room_message.class.to_s.underscore, sender: sender, receiver: receiver)
      render json: { status: :true }
    else
      current_user.refund_credits(@credits) if @credits.present?
      if @room_message.errors.present?
        error_message = @room_message.errors.full_messages.join(", ")
      else
        error_message = I18n.t("unvalid_room_message", reason: @room_message.unvalid_reason.to_s)
      end
      render js: "toastr['error']('#{error_message}');"
    end
  end
  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end

  def room_message_params
    params.require(:room_message).permit(:message, :receiver_id,:author_id,:room_id)
  end
end
