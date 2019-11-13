class AddStripeIntentIdToQuote < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :stripe_intent_id, :string
    add_column :invoices, :stripe_intent_id, :string
  end
end
