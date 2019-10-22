module StripeCard
  class << self
    def create_setup_intent usage = "on_session"
      Stripe::SetupIntent.create({
         usage: usage, # The default usage is off_session
       })
    end

    def attach intent_method_id, user
      StripeCustomer.set_user user
      payment_method = Stripe::PaymentMethod.attach(
        intent_method_id,
        {
          customer: stripe_customer_id
        }
      )
      user.update last_stripe_payment_method_id: payment_method.id
    end
  end
end
