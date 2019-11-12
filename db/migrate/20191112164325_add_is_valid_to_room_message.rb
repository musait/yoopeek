class AddIsValidToRoomMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :room_messages, :is_valid, :boolean, default: :true
    add_column :room_messages, :unvalid_reason, :string
  end
end
