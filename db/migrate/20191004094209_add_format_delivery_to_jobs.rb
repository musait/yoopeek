class AddFormatDeliveryToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :format_delivery,type: :uuid, foreign_key: true
  end
end
