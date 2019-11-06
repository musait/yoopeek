class QuoteElement < ApplicationRecord
  belongs_to :quote
  validates_numericality_of :price, presence: true, :message => :is_not_a_number
  validates_presence_of :content, message: :must_be_present
end
