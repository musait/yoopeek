class AddAvailablePayoutAmountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :available_payout_amount, :float
  end
end
