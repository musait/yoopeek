class AddPriceRateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :price_rate, :integer
  end
end
