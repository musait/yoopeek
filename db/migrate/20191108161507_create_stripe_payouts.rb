class CreateStripePayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :stripe_payouts, id: :uuid do |t|
      t.string :stripe_payout_id
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
