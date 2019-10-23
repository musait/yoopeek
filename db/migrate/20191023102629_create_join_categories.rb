class CreateJoinCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :join_categories, id: :uuid do |t|
      t.belongs_to :category, type: :uuid
      t.belongs_to :subcategory, type: :uuid
      t.timestamps
    end

  end
end
