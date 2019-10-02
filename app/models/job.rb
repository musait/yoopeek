class Job < ApplicationRecord
  belongs_to :category
  belongs_to :worker, optional: true
  belongs_to :customer
  has_many :reviews
  def price_range
    "#{self.min_price} - #{self.max_price}" # or as an array, or however you want to return it
  end
  def time_range
    "#{self.min_time} - #{self.max_time}" # or as an array, or however you want to return it
  end
end
