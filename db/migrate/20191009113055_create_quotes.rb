class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes, id: :uuid do |t|
      t.string :name
      t.uuid :sender_id
      t.uuid :receiver_id
      t.timestamps
    end

  end
end
