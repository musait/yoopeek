class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|

      t.string :name
      t.string :iban
      t.string :bic
      t.string :bank_name
      t.string :address
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
