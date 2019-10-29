class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios, id: :uuid do |t|
      t.timestamps
    end
  end
end
