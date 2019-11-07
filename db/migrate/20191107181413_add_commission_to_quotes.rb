class AddCommissionToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :commission_collected, :float
    add_column :invoices, :commission_collected, :float
  end
end
