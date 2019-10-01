class AddCategoryToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :category,type: :uuid, foreign_key: true
  end
end
