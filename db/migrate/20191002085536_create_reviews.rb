class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews, id: :uuid do |t|
      t.text :content
      t.integer :stars
      t.uuid :customer_id
      t.uuid :worker_id
      t.belongs_to :customer, foreign_key: {to_table: :users}, type: :uuid
      t.belongs_to :worker, foreign_key: {to_table: :users}, type: :uuid
      t.references :job,type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
