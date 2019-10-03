class AddSlugToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :slug, :string, null: false
    add_index :jobs, :slug, unique: true
  end
end
