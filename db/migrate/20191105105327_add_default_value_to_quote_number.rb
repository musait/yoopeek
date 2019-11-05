class AddDefaultValueToQuoteNumber < ActiveRecord::Migration[5.2]
  def up
    change_column :quotes, :quote_number, :bigint, default: 0
  end

  def down
    change_column :quotes, :quote_number, :bigint, default: nil
  end
end
