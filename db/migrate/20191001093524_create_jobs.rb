class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :localisation
      t.text :optional_services, array: true, default: []
      t.integer :min_price
      t.integer :max_price
      t.integer :min_time
      t.integer :max_time
      t.timestamps
    end
  end
end
