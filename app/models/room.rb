class Room < ApplicationRecord
  has_many :room_messages, dependent: :destroy, inverse_of: :room
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :job

end
