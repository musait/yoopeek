class AddPinterestProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pinterest_profile, :string
  end
end
