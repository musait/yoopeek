class Quote < ApplicationRecord
  has_many :quote_elements
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :user
  enum status: [:created, :declined, :accepted]
end
