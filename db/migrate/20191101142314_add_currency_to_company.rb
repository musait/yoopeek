class AddCurrencyToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :currency, :string
  end
end
