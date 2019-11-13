class Invoice < ApplicationRecord
  has_many :invoice_elements, dependent: :destroy
  accepts_nested_attributes_for :invoice_elements,:reject_if => :all_blank, :allow_destroy => true
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
  belongs_to :job
  belongs_to :quote, optional: true
  has_many :notifications

  def total
    invoice_elements.sum(:total)
  end

  after_create do
    sender.update available_payout_amount: sender.available_payout_amount + (total_within_vat - commission_collected.to_f)
  end

  before_validation do
    self.invoice_number = Invoice.where(job_id: job_id).count + 1 if self.invoice_number.blank?
    self.commission_invoice_number = (CreditsPayment.count + Subscription.count + Invoice.count) + 1 if self.commission_invoice_number.blank?
  end
end
