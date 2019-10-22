module StripeCustomer

  def self.create user
      customer = Stripe::Customer.create(
        :email => user.email
      )

      user.update stripe_customer_id: customer.id
      customer
  end

  def self.set_user user
    stripe_customer_id = user.stripe_customer_id
    if stripe_customer_id.blank?
      customer = create user
      stripe_customer_id = customer.id
    end
    stripe_customer_id
  end

  def self.get user
    if user.stripe_customer_id.present?
      begin
        customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      rescue Stripe::InvalidRequestError => e
        customer = create user
      end
    else
      customer = create user
    end
    customer
  end
end
