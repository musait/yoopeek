class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan_limitation

  scope :actived, -> () {
    where(is_active: true)
  }
  scope :current_actived_subscriptions, -> () {
    where("end_at > ? and is_active = ?", Time.current, true).order(:created_at => :desc)
  }

  after_create do
    user.add_credits (plan_limitation.nb_answer * Rails.application.credentials.dig(:message_price).to_f)
  end
end
