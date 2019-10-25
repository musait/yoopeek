class AddWebsiteToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :website, :string
  end
end
