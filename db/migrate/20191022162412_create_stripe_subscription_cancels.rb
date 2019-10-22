class CreateStripeSubscriptionCancels < ActiveRecord::Migration[5.2]
  def change
    create_table :stripe_subscription_cancels, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.datetime :subscription_end_at
      t.float :plan_amount
      t.string :stripe_subscription_id
      t.string :stripe_plan_id

      t.timestamps
    end
  end
end
