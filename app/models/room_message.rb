class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  acts_as_readable on: :created_at
  has_one :notification, dependent: :destroy
  after_create :create_notification
  validate :check_author_credits,unless: -> {author.email == "yoopeek@yoopeek.com"}

  def check_author_credits
    worker = author.worker? ? author : receiver
    errors.add "credits", I18n.t("not_enougth_credits") if room.room_messages.where(author_id: worker.id).count == 0 &&!CreditChangement.exists?(room_id: room_id, user_id: worker.id)
  end
end
