class CreateCreditsPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :credits_payments, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.float :credits_add
      t.float :amount
      t.string :stripe_intent_id
      t.string :stripe_payment_method_id

      t.timestamps
    end
  end
end
