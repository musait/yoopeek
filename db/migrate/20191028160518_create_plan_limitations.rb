class CreatePlanLimitations < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_limitations, id: :uuid do |t|
      t.string :name
      t.string :label
      t.string :description
      t.float :price_per_month, default: 0
      t.float :commission_per_service, default: 19
      t.integer :commission_type, default: 0
      t.integer :nb_answer, default: 6
      t.integer :nb_answer_type, default: 0
      t.integer :limit_portfolio, default: 0
      t.boolean :have_badge, default: false
      t.boolean :have_status, default: false
      t.integer :show_order, default: 0

      t.timestamps
    end
  end
end
