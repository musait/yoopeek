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
      t.belongs_to :customer, foreign_key: {to_table: :users}, type: :uuid
      t.belongs_to :worker, foreign_key: {to_table: :users}, type: :uuid
      t.column :status, :integer, default: 0
      t.timestamps
    end
  end
end
