class StripeSubscriptionCancel < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  before_create do
    subscription.update is_active: false
  end
end
