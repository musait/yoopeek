class Job < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :worker, optional: true
  belongs_to :customer
  belongs_to :format_delivery
  has_many :rooms
  has_many :reviews
  has_many :quotes
  after_validation :set_slug, only: [:create, :update]
  enum status: [:created, :in_progress, :completed, :cancelled]
  def price_range
    "#{self.min_price} - #{self.max_price}" # or as an array, or however you want to return it
  end
  def time_range
    "#{self.min_time} - #{self.max_time}" # or as an array, or however you want to return it
  end
  def set_slug
    self.slug = name.to_s.parameterize
  end
  def to_param
  "#{slug}"
end
end
