class Quote < ApplicationRecord
  has_many :quote_elements, dependent: :destroy
  accepts_nested_attributes_for :quote_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :job
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  has_many :notifications

  enum status: [:created, :declined, :accepted, :paid]
  before_create :increment_quote
  after_save :send_notification_and_email, if :status_changed?

  def total
    quote_elements.sum(:total)
  end

  def create_invoice
    invoice = Invoice.create attributes.except!("id", "quote_element_id", "status", "quote_number", "user_id").merge!(quote_id: id)
    quote_elements.each do |quote_element|
      InvoiceElement.create quote_element.attributes.except!("quote_id").merge!(invoice_id: invoice.id)
    end
  end

  def increment_quote
    self.quote_number = Quote.where(job_id: self.job.id).count + 1
  end

  def send_notification_and_email
    case self.status
      when "created"
        Notification.create!(message: I18n.t('.quotes.create.you_have_received_a_quote',pro: self.sender.full_name, job: self.job.name), quote: self,created_for: self.class.to_s.underscore, sender: self.sender, receiver: self.receiver)
        UserMailer.with(user: self.receiver, quote: self).new_quote.deliver_now
      when "paid"
        Notification.create!(message: I18n.t('.quotes.accept.your_quote_has_been_paid',job: self.job.name), quote: self, created_for: self.class.to_s.underscore, sender: self.receiver, receiver: self.sender)
        UserMailer.with(user: self.sender, quote: self).quote_paid.deliver_now
      when "declined"
        Notification.create!(message: I18n.t('.your_quote_has_been_declined',job: self.job.name), quote: self, created_for: self.class.to_s.underscore, sender: self.sender, receiver: self.receiver)
        UserMailer.with(user: self.sender, quote: self).quote_declined.deliver_now
      end
    end
  end

end
