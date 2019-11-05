class Quote < ApplicationRecord
  has_many :quote_elements, dependent: :destroy
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :notifications

  enum status: [:created, :declined, :accepted]
  before_create :increment_quote


  def total
    quote_elements.sum(:total)
  end

  def increment_quote
    self.quote_number = Quote.where(job_id: self.job.id).count + 1
  end
end
