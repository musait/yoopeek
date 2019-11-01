class AddFacebookProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :facebook_profile, :string
  end
end
