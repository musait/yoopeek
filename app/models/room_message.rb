class RoomMessage < ApplicationRecord
  belongs_to :room
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  acts_as_readable on: :created_at
  has_one :notification
  after_create :create_notification

  def create_notification
    Notification.create_for receiver, self
  end
end
