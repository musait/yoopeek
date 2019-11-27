class Subscription < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :plan_limitation

  scope :actived, -> () {
    where(is_active: true)
  }
  scope :current_actived_subscriptions, -> () {
    where("end_at >= ? and is_active = ?", Time.current, true).order(:created_at => :desc)
  }

  before_validation do
    self.invoice_number = (CreditsPayment.count + Subscription.count + Invoice.count) + 1 if self.invoice_number.blank?
  end
  after_create do
    credits = (plan_limitation.nb_answer * Rails.application.credentials.dig(:message_price).to_f)
    user.add_credits credits, "subscription", self
  end
end
