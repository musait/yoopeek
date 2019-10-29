class AddPortfolioToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :portfolio,type: :uuid, foreign_key: true
  end
end
