class CreateJoinUserSubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :join_user_subcategories do |t|
      t.belongs_to :user, type: :uuid
      t.belongs_to :subcategory, type: :uuid

      t.timestamps
    end
  end
end
