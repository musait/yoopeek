class AddCategoryToTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :category, type: :uuid, foreign_key: true
  end
end
