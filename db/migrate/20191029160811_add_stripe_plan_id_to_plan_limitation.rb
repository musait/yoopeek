class AddStripePlanIdToPlanLimitation < ActiveRecord::Migration[5.2]
  def change
    add_column :plan_limitations, :stripe_plan_id, :string
  end
end
