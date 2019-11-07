class AddInvoiceNumberToCreditsPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :credits_payments, :invoice_number, :integer
  end
end
