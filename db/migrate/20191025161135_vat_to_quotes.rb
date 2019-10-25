class VatToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :vat, :integer

  end
end
