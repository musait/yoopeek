class AddUserToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :quotes, :user, type: :uuid, foreign_key: true
  end
end
