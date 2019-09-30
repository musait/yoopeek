class AddBicToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :bic, :string
  end
end
