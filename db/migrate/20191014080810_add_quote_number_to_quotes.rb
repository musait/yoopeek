class AddQuoteNumberToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :quote_number, :bigint
  end
end
