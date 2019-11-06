class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices, id: :uuid do |t|
      t.string :name
      t.belongs_to :sender, foreign_key: {to_table: :users}, type: :uuid
      t.belongs_to :receiver, foreign_key: {to_table: :users}, type: :uuid
      t.belongs_to :job, type: :uuid, foreign_key: true
      t.belongs_to :quote, type: :uuid, foreign_key: true
      t.integer :invoice_number
      t.integer :vat
      t.integer :total_within_vat
      t.integer :total_without_vat

      t.timestamps
    end
  end
end
