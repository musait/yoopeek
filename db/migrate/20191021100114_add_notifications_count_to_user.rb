class AddNotificationsCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notifications_count, :integer
  end
end
