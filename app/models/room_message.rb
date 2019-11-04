class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  acts_as_readable on: :created_at
  has_one :notification
  after_create :create_notification
  validate :check_author_credits

  def check_author_credits
    if author.worker?
      errors.add "credits", I18n.t("not_enougth_credits") if room.room_messages.where(author_id: author.id).count > 0
    end
  end

  def create_notification
    Notification.create_for receiver, self
  end
end
