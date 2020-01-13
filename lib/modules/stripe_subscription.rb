module StripeSubscription
  class << self
    def create user, plan_id, plan_limitation = nil, trial_period = nil
      plan_limitation ||= PlanLimitation.find_by stripe_plan_id: plan_id
      plan = Stripe::Plan.retrieve(plan_id)
      cancel_subscription(user) if user.stripe_subscription_id.present?
      amount = plan['amount'] / 100.0
      if trial_period.present?
        subscription = Stripe::Subscription.create({
          customer: user.stripe_customer_id,
          default_payment_method: user.last_stripe_payment_method_id,
          items: [
            {
              plan: plan_id,
            },
          ],
          trial_end: trial_period.to_i,
          cancel_at_period_end: true,
        })
      else
        subscription = Stripe::Subscription.create({
          customer: user.stripe_customer_id,
          default_payment_method: user.last_stripe_payment_method_id,
          items: [
            {
              plan: plan_id,
            },
          ]
        })
      end

      # user.update stripe_subscription_id: subscription.id, current_plan_amount: amount, stripe_plan_id: plan_id, subscription_end_at: Time.at(subscription['current_period_end'])
      # Subscription.create user: user, plan_limitation: plan_limitation, plan_amount: amount, stripe_plan_id: plan_id, end_at: Time.at(subscription['current_period_end']), stripe_subscription_id: subscription.id
    end

    def switch_plan user, plan_id, plan_limitation = nil, trial_period = nil
      subscription_items = [{ plan: plan_id}]
      if user.stripe_subscription_id.present?
        if user.current_subscription.present? &&user.current_subscription.stripe_plan_id.present?
          plan = Stripe::Plan.retrieve(plan_id)
          user_plan = Stripe::Plan.retrieve(user.current_subscription.stripe_plan_id)

          if user_plan.amount > plan.amount
            cancel_subscription user, true
            subscription = create user, plan_id, plan_limitation, trial_period
          else
            cancel_subscription user
            subscription = create user, plan_id, plan_limitation, trial_period
          end
        else
          cancel_subscription user
          subscription = create user, plan_id, plan_limitation, trial_period
        end
      else
        cancel_subscription user
        subscription = create user, plan_id, plan_limitation, trial_period
      end
      subscription
    end

    def cancel_subscription user, cancel_at_period_end = false
      begin
        if user.stripe_subscription_id.present?
          if cancel_at_period_end
            # begin
              subscription = Stripe::Subscription.update(
                user.stripe_subscription_id,
                {
                  cancel_at_period_end: true,
                }
              )
              StripeSubscriptionCancel.create! user: user, subscription_end_at: Time.at(subscription['current_period_end']), plan_amount: user.current_plan_amount, stripe_subscription_id: user.stripe_subscription_id, stripe_plan_id: user.stripe_plan_id, subscription: user.current_subscription
            # rescue
            #   StripeSubscriptionCancel.create! user: user, subscription_end_at: Time.current, plan_amount: user.current_plan_amount, stripe_subscription_id: user.stripe_subscription_id, stripe_plan_id: user.stripe_plan_id, subscription: user.current_subscription
            # end
          else
            begin
              subscription = Stripe::Subscription.retrieve(user.stripe_subscription_id)
              if subscription.present?
                subscription.delete
                user_subscription = Subscription.find_by stripe_subscription_id: subscription.id
                StripeSubscriptionCancel.create! user: user, subscription_end_at: Time.at(subscription['current_period_end']), plan_amount: user.current_plan_amount, stripe_subscription_id: user.stripe_subscription_id, stripe_plan_id: user.stripe_plan_id, subscription: user_subscription
                user_subscription.update is_active: false
                user.update subscription_end_at: Time.at(subscription['current_period_end']), current_plan_amount: nil, stripe_subscription_id: nil, stripe_plan_id: nil
              end
            rescue => e
              p e
            end
          end
        end
      rescue => e
        p "error", e
      end
    end
  end
end
