class CreateCreditsOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :credits_offers, id: :uuid do |t|
      t.float :credits
      t.float :price
      t.float :reduction

      t.timestamps
    end
  end
end
