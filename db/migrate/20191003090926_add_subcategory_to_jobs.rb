class AddSubcategoryToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :subcategory,type: :uuid, foreign_key: true
  end
end
