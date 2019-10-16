class AddAddressToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :address,type: :uuid, foreign_key: true
  end
end
