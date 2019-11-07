class CreditsPayment < ApplicationRecord
  belongs_to :user
  belongs_to :credits_offer, optional: true
  before_validation do
    self.invoice_number = (CreditsPayment.count + Subscription.count + Invoice.count) + 1 if self.invoice_number.blank?
  end
  after_create do
    user.add_credits credits_add, "credits_payment", self
  end
end
