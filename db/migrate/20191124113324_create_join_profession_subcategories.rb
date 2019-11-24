class CreateJoinProfessionSubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :join_profession_subcategories do |t|
      t.belongs_to :profession, type: :uuid
      t.belongs_to :subcategory, type: :uuid
      t.timestamps
    end
  end
end
