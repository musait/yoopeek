class AddJobToRooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :rooms, :job,type: :uuid, foreign_key: true
  end
end
