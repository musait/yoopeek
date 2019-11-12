class CreateForbidenWords < ActiveRecord::Migration[5.2]
  def change
    create_table :forbiden_words, id: :uuid do |t|
      t.string :word
      t.boolean :is_valid_after_quote_accepted, default: false

      t.timestamps
    end
  end
end
