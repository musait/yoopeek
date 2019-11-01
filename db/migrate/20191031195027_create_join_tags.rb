class CreateJoinTags < ActiveRecord::Migration[5.2]
  def change
    create_table :join_tags, id: :uuid do |t|
      t.belongs_to :category, type: :uuid
      t.belongs_to :tag, type: :uuid
      t.timestamps
    end
  end
end
