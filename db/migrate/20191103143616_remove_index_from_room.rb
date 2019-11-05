class RemoveIndexFromRoom < ActiveRecord::Migration[5.2]
  def change
    remove_index "rooms", name: "index_rooms_on_author_id_and_receiver_id"
  end
end
