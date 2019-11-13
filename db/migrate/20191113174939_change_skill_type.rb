class ChangeSkillType < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :skill, :text, array: true, default: [], using: "(string_to_array(skill, ','))"
    rename_column :users, :skill, :skills
  end

  def down
    change_column :users, :skill, :string
  end
end
