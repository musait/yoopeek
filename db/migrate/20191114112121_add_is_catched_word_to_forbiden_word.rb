class AddIsCatchedWordToForbidenWord < ActiveRecord::Migration[5.2]
  def change
    add_column :forbiden_words, :is_catched_word, :boolean, default: false
    add_column :room_messages, :is_catched, :boolean, default: false
    add_column :room_messages, :catched_reason, :string
  end
end
