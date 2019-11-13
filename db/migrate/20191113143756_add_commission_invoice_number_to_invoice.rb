class AddCommissionInvoiceNumberToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :commission_invoice_number, :integer
  end
end
