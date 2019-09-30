class AddIbanToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :iban, :string
  end
end
