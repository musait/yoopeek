class AddVatRateToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :vat_rate, :string
  end
end
