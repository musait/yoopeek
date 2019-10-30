class AddJobToPortfolios < ActiveRecord::Migration[5.2]
  def change
    add_reference :portfolios, :job, type: :uuid, foreign_key: true
  end
end
