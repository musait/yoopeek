class AddStripeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_account_id, :string
    add_column :users, :last_stripe_payment_method_id, :string
    add_column :users, :stripe, :string
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :stripe_plan_id, :string
    add_column :users, :current_plan_amount, :float
  end
end
