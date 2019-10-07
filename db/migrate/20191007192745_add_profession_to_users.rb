class AddProfessionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :profession,type: :uuid, foreign_key: true
  end
end
