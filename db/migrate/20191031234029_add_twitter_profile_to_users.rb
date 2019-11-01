class AddTwitterProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_profile, :string
  end
end
