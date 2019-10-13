class Quote < ApplicationRecord
  has_many :quote_elements
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :creator, :class_name => "Worker", :foreign_key => "user_id" 
  enum status: [:created, :in_progress, :cancelled]
end
