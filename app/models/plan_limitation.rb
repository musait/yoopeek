class PlanLimitation < ApplicationRecord
  enum commission_type: ["%", "€"]
  enum nb_answer_type: ["month", "year"]

  def self.free_limitation
    where(name: "free").first_or_create(
      label: "Sans abo",
      description: "plan gratuit.",
      price_per_month: (0),
      commission_per_service: 19,
      commission_type: "%",
      nb_answer: 0,
      nb_answer_type: "month",
      limit_portfolio: 0,
      limit_portfolio_content: 0,
      have_badge: false,
      have_status: false,
      show_order: 0
    )
  end
  def self.classic_limitation
    where(name: "classic").first_or_create(
      label: "Abo 19€/mois",
      description: "Abo 19€/mois",
      price_per_month: 19,
      commission_per_service: 1,
      commission_type: "€",
      nb_answer: 5,
      nb_answer_type: "month",
      limit_portfolio: 5,
      limit_portfolio_content: 15,
      have_badge: false,
      have_status: false,
      show_order: 1
    )
  end
  def self.premium_limitation
    where(name: "premium").first_or_create(
      label: "Abo 49€/mois",
      description: "Abo 49€/mois",
      price_per_month: 49,
      commission_per_service: 1,
      commission_type: "€",
      nb_answer: 50,
      nb_answer_type: "month",
      limit_portfolio: nil,
      limit_portfolio_content: nil,
      have_badge: true,
      have_status: true,
      show_order: 2
    )
  end

  def limit_portfolio_to_s
    limit_portfolio.present? ? limit_portfolio : I18n.t("unlimited")
  end
  def limit_portfolio_content_to_s
    limit_portfolio_content.present? ? limit_portfolio_content : I18n.t("unlimited")
  end
end
