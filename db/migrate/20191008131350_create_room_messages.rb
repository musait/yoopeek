class CreateRoomMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :room_messages, id: :uuid do |t|
      t.references :room, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
