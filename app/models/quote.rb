class Quote < ApplicationRecord
  has_many :quote_elements
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :user
  has_one :notification
  
  enum status: [:created, :declined, :accepted]

  after_create :create_notification

  def create_notification
    Notification.create_for user, self
  end
end
