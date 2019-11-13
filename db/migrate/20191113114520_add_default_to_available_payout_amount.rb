class AddDefaultToAvailablePayoutAmount < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :available_payout_amount, from: nil, to: 0
  end
end
