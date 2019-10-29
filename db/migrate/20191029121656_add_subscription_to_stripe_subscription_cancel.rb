class AddSubscriptionToStripeSubscriptionCancel < ActiveRecord::Migration[5.2]
  def change
    add_reference :stripe_subscription_cancels, :subscription, type: :uuid, foreign_key: true
  end
end
