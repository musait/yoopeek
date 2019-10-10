class RoomMessage < ApplicationRecord
  belongs_to :room, inverse_of: :room_messages
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  acts_as_readable on: :created_at
end
