class AddStripeConnectToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_person_id, :string
  end
end
