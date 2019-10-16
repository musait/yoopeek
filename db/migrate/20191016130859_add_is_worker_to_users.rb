class AddIsWorkerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_worker, :boolean
  end
end
