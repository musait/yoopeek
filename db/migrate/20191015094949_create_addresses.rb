class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :street
      t.string :city
      t.string :country
      t.string :zip

      t.timestamps
    end
  end
end
