class CreateQuoteElements < ActiveRecord::Migration[5.2]
  def change
    create_table :quote_elements, id: :uuid do |t|
      t.text :content
      t.integer :quantity
      t.integer :price
      t.integer :total
      t.references :quote, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
