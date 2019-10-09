class AddQuoteElementToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :quotes, :quote_element,type: :uuid, foreign_key: true
  end
end
