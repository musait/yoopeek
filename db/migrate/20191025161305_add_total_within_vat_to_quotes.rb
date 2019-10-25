class AddTotalWithinVatToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :total_within_vat, :integer
  end
end
