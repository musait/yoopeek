class CreateInvoiceElements < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_elements do |t|
      t.string :content
      t.integer :quantity
      t.float :price
      t.float :total
      t.belongs_to :invoice, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
