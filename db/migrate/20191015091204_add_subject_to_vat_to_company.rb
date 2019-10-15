class AddSubjectToVatToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :subject_to_vat, :boolean
  end
end
