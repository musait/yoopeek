class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies, id: :uuid do |t|

      t.string :name, default: " "
      t.string :iban
      t.string :bic
      t.string :bank_name
      t.string :address
      t.belongs_to :worker, foreign_key: {to_table: :users}, type: :uuid
      t.timestamps
    end
  end
end
