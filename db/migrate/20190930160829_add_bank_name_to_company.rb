class AddBankNameToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :bank_name, :string
  end
end
