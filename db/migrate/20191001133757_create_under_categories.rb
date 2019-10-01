class CreateUnderCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :under_categories, id: :uuid do |t|
      t.string :name
      t.references :category,type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
