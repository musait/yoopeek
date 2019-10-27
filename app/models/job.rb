class Job < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :worker, optional: true
  belongs_to :customer
  belongs_to :format_delivery
  has_many :rooms
  has_many :reviews
  has_many :quotes
  has_one :notification
  paginates_per 3

  after_validation :set_slug, only: [:create, :update]
  enum status: [:created, :in_progress, :completed, :cancelled]

  after_create :create_notification

  def create_notification
    # Notification.create_for customer,worker, self
  end
  def price_range
    "#{self.min_price} - #{self.max_price}"
  end
  def time_range
    "#{self.min_time} - #{self.max_time}"
  end
  def set_slug
    self.slug = name.to_s.parameterize
  end
  def to_param
  "#{slug}"
end
end
