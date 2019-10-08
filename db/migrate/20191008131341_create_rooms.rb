class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.uuid :author_id
      t.uuid :receiver_id

      t.timestamps
    end
    add_index :rooms, :name,  unique: true
    add_index :rooms, :author_id
    add_index :rooms, :receiver_id
    add_index :rooms, [:author_id, :receiver_id], unique: true
  end
end
