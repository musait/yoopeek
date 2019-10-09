class CreateRoomMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :room_messages, id: :uuid do |t|
      t.references :room, type: :uuid, foreign_key: true
      t.uuid :author_id
      t.uuid :receiver_id
      t.text :message

      t.timestamps
    end
    add_index :room_messages, :author_id
    add_index :room_messages, :receiver_id
  end
end
