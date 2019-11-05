class AddDefaultValueToQuoteElement < ActiveRecord::Migration[5.2]
  def up
    change_column :quote_elements, :quantity, :integer, default: 1
  end

  def down
    change_column :quote_elements, :quantity, :integer, default: nil
  end
end
