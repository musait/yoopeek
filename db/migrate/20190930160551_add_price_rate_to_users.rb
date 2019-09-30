class AddPriceRateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :PriceRate, :integer
  end
end
