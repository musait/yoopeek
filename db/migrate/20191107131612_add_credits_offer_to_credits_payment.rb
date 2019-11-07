class AddCreditsOfferToCreditsPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :credits_payments, :credits_offer, type: :uuid, foreign_key: true
  end
end
