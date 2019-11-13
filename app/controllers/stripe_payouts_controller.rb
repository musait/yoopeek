class StripePayoutsController < ApplicationController
  before_action :set_stripe_payout, only: [:show]

  # GET /stripe_payouts
  # GET /stripe_payouts.json
  def index
    @stripe_payouts = current_user.stripe_payouts
  end
  def show
    @stripe_payout = StripePayout.find(params[:id])
    respond_to do |format|
      format.pdf do
        @customer = @stripe_payout.user
        @total = @stripe_payout.plan_amount
        @amount_without_taxes = @total / 1.077
        @taxes = @amount_without_taxes * 7.7 / 100
        render pdf: "invoice",
          encoding: "UTF-8",
          margin: {left: "15px", right: "15px", bottom: "15px", top: "15px"},
          layout: 'pdf.html',
          # show_as_html: false

          # header: { :content => render_to_string({:template => "/layouts/pdf_header.html.erb", layout: false })},
          disposition: 'attachment'
      end
    end
  end

  # POST /stripe_payouts
  # POST /stripe_payouts.json
  def create
    company = current_user.company
    if current_user.available_payout_amount >= 1
      if company.present? &&current_user.company.currency.present?
        payout = Stripe::Payout.create({
          amount: (current_user.available_payout_amount * 100).to_i,
          currency: current_user.company.currency,
        })
        StripePayout.create stripe_payout_id: payout.id, user_id: current_user.id, amount: current_user.available_payout_amount
        result = {message: I18n.t("available_payout_amount_sent"), state: :success}
      else
        result = {message: I18n.t("fill_all_company_fields"), state: :error}
      end
    else
      result = {message: I18n.t("not_enougth_available_payout_amount"), state: :error}
    end
    redirect_back fallback_location: root_path, flash: {result[:state] => result[:message]}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_stripe_payout
      @stripe_payout = StripePayout.find_by(id: params[:id])
  end
end
