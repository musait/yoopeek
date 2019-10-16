class AddVatNumberToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :vat_number, :string
  end
end
