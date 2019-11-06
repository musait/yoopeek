class Quote < ApplicationRecord
  has_many :quote_elements, dependent: :destroy
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :notifications

  enum status: [:created, :declined, :accepted]
  before_create :increment_quote
  after_create :send_notification
  after_create :send_email_after_quote_creation


  def total
    quote_elements.sum(:total)
  end

  def increment_quote
    self.quote_number = Quote.where(job_id: self.job.id).count + 1
  end

  def send_notification
    Notification.create!(message: I18n.t('.quotes.create.you_have_received_a_quote',pro: self.sender.full_name, job: self.job.name), quote: self,created_for: self.class.to_s.underscore, sender: self.sender, receiver: self.receiver)
  end

  def send_email_after_quote_creation
    UserMailer.with(user: self.sender, quote: self).new_quote.deliver_later
  end
end
