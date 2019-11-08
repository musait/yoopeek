class AddLimitPortfolioContentToPlanLimitation < ActiveRecord::Migration[5.2]
  def change
    add_column :plan_limitations, :limit_portfolio_content, :integer
  end
end
