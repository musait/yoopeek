class Job < ApplicationRecord
  belongs_to :category
  belongs_to :user
  def price_range
    "#{self.min_price} - #{self.max_price}" # or as an array, or however you want to return it
  end
  def time_range
    "#{self.min_time} - #{self.max_time}" # or as an array, or however you want to return it
  end
end
