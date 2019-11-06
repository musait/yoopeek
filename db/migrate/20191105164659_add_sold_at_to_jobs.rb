class AddSoldAtToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :sold_at, :integer, default: 0
  end
end
