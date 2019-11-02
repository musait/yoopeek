class AddCreditsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_credits, :float, default: 0
    add_column :users, :total_credits, :float, default: 0
  end
end
