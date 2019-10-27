class Quote < ApplicationRecord
  has_many :quote_elements
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :notifications

  enum status: [:created, :declined, :accepted]

  after_create :create_notification

  def create_notification
    Notification.create_for sender,receiver, self
  end
end
