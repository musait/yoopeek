class AddAddressToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :address,type: :uuid, foreign_key: true
  end
end
