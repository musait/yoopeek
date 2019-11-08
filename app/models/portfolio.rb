class Portfolio < ApplicationRecord
  belongs_to :user
  has_many_attached :picture
  validate :check_user_plan

  def check_user_plan
    plan_limitation = user.current_plan
    errors.add "plan", I18n.t("portfolio_limit_number", limit: plan_limitation.limit_portfolio_to_s, plan: plan_limitation.label) if( plan_limitation.limit_portfolio.present? &&plan_limitation.limit_portfolio <= 0)
  end
  def picture_url
    if picture.attached?
      ActiveStorage::Current.set(host: Rails.application.credentials.dig(Rails.env.to_sym, :host)) do
        picture[0].service_url
      end
    else
      ActionController::Base.helpers.asset_path 'logo.png'
    end
  end
end
