class Job < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :worker, optional: true
  belongs_to :customer
  belongs_to :format_delivery
  has_many :rooms
  has_many :quotes
  has_one :invoice
  has_one :notification
  paginates_per 3
  validates_numericality_of :max_price, presence: true, :message => :is_not_a_number
  validates_numericality_of :min_price, presence: true, :message => :is_not_a_number
  validates_numericality_of :min_time, presence: true, :message => :is_not_a_number
  validates_numericality_of :max_time, presence: true, :message => :is_not_a_number
  validates :date_delivery, not_in_past: true,:allow_blank => false, :if => :date_delivery_changed?

  after_validation :set_slug, only: [:create, :update]
  enum status: [:created, :in_progress, :cancelled, :completed_by_worker, :completed_by_customer]

  after_create :create_notification

  def current_quote
    quotes.order(:created_at).last
  end

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
