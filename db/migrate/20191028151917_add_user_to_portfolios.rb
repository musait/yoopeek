class AddUserToPortfolios < ActiveRecord::Migration[5.2]
  def change
    add_reference :portfolios, :user,type: :uuid, foreign_key: true
  end
end
