class AddCategoryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :category,type: :uuid, foreign_key: true
  end
end
