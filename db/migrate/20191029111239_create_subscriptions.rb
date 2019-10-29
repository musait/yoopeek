class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :plan_limitation, type: :uuid, foreign_key: true
      t.float :plan_amount
      t.string :stripe_plan_id
      t.string :stripe_subscription_id
      t.datetime :subscription_canceled_at
      t.datetime :end_at
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
