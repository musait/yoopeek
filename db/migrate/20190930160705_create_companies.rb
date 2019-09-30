class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies, id: :uuid do |t|

      t.string :name
      t.string :iban
      t.string :bic
      t.string :bank_name
      t.string :address
      t.references :user,type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
