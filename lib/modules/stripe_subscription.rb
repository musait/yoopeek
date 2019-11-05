module StripeSubscription
  class << self
    def create user, plan_id, plan_limitation = nil
      plan_limitation ||= PlanLimitation.find_by stripe_plan_id: plan_id
      plan = Stripe::Plan.retrieve(plan_id)
      cancel_subscription(user) if user.stripe_subscription_id.present?
      amount = plan['amount'] / 100.0

      subscription = Stripe::Subscription.create({
        customer: user.stripe_customer_id,
        default_payment_method: user.last_stripe_payment_method_id,
        items: [
          {
            plan: plan_id,
          },
        ]
      })
      # user.update stripe_subscription_id: subscription.id, current_plan_amount: amount, stripe_plan_id: plan_id, subscription_end_at: Time.at(subscription['current_period_end'])
      # Subscription.create user: user, plan_limitation: plan_limitation, plan_amount: amount, stripe_plan_id: plan_id, end_at: Time.at(subscription['current_period_end']), stripe_subscription_id: subscription.id
    end

    def cancel_subscription user
      begin
        if user.stripe_subscription_id.present?
          subscription = Stripe::Subscription.retrieve(user.stripe_subscription_id)
          subscription.delete
          StripeSubscriptionCancel.create! user: user, subscription_end_at: Time.at(subscription['current_period_end']), plan_amount: user.current_plan_amount, stripe_subscription_id: user.stripe_subscription_id, stripe_plan_id: user.stripe_plan_id, subscription: user.current_subscription
          user.update subscription_end_at: Time.at(subscription['current_period_end']), current_plan_amount: nil, stripe_subscription_id: nil, stripe_plan_id: nil
        end
      rescue => e
        p "error", e
      end
    end
  end
end
