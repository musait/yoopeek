class AddStripeConnectBankIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_connect_bank_id, :string
  end
end
