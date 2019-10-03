class AddDateDeliveryToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :date_delivery, :date
  end
end
