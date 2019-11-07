class Room < ApplicationRecord
  has_many :room_messages, dependent: :destroy
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :job, optional: true
  validates :job_id, presence: true, unless: -> {author.email == "yoopeek@yoopeek.com"}

  scope :with_receiver, -> (user) { where(receiver_id: user.id)}
  scope :with_author, -> (user) { where(author_id: user.id)}

  def other_user user
    user.id == author_id ? receiver : author
  end

end
