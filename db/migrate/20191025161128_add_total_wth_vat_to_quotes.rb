class AddTotalWthVatToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :total_without_vat, :integer
  end
end
