class PlanLimitation < ApplicationRecord
  enum commission_type: ["%", "€"]
  enum nb_answer_type: ["month", "year"]

  before_validation do
    if self.price_per_month_changed?
      stripe_plan = Stripe::Plan.create({
        amount: (self.price_per_month * 100).to_i,
        currency: 'eur',
        interval: 'month',
        product: {name: "YOOPEEK #{self.label}"},
      })

      self.stripe_plan_id = stripe_plan.id
    end
  end
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
      label: "Abo 29€/mois",
      description: "Abo 29€/mois",
      price_per_month: 29,
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
      label: "Abo 69€/mois",
      description: "Abo 69€/mois",
      price_per_month: 69,
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
