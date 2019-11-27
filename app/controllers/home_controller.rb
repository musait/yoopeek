class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search_result, :stripe_subscription_webhook,:get_subcategories]
  skip_before_action :verify_authenticity_token, only: [:stripe_subscription_webhook]

  def index
    @professions = Profession.all
    @profession= Profession.find_by(id: params[:category_id]) || @professions.first
    @subcategories = @profession.subcategories || Subcategory.all
  end
  def search_result
    @workers = []
    if params[:profession].present?
      @profession = Profession.find(params[:profession])
      @workers = Worker.joins(:profession).where(professions: {name: @profession.name}).page(params[:page])
      if @workers.present? && params[:subcategory].present?
        @subcategory = Subcategory.find(params[:subcategory])
        @workers = @workers.includes(:subcategories).where(subcategories: {name: @subcategory.name }).page(params[:page])
      end
    else
      @workers = Worker.all.page(params[:page])
    end
    if params[:city].present?
      @workers = @workers.joins(:company => [:address]).where(addresses: {city: params[:city].split(',')[0]}).page(params[:page])
    end
  end
  def get_subcategories
    @professions = Profession.all
    @profession = Profession.find_by(id: params[:profession_id]) || @professions.first
    @subcategories = @profession.subcategories || Subcategory.all
  end
  def checkout_credit
    @credits_offer = CreditsOffer.find(params[:id])
    @intent = Stripe::PaymentIntent.create({
      amount: (@credits_offer.price * 100).to_i,
      currency: 'eur',
      customer: current_user.stripe_customer_id,
    })
    if current_user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        :email => current_user.email
      )
      current_user.update stripe_customer_id: customer.id
    end
    session[:credits_offer_id] = params[:id]
  end
  def credits_payments_invoices
    @credits_payments = current_user.credits_payments
  end
  def invoice_credits_payment
    @credits_payment = CreditsPayment.find(params[:id])
    respond_to do |format|
      format.pdf do
        @customer = @credits_payment.user
        @total = @credits_payment.amount
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
    # UserMailer.with(user: @credits_payment.user, invoice: @credits_payment).new_invoice.deliver_now
  end
  def buy_credits
    @credits_offers = CreditsOffer.order(:price, reduction: :desc).all
  end
  def stripe_subscription_webhook
    object = params["data"]["object"]
    user = User.find_by stripe_customer_id: object["customer"]
    if user.present?
      case params["type"]
      when 'invoice.payment_succeeded'
        plan_id = object["lines"]["data"][0]["plan"]["id"]
        subscription_id = object["lines"]["data"][0]["id"]
        subscription_object = object["lines"]["data"][0]
        subscription_end = subscription_object["period"]["end"]
        # subscription = Stripe::Subscription.retrieve(subscription_id)
        plan_limitation = PlanLimitation.find_by(stripe_plan_id: plan_id)
        amount = (object["amount_due"].to_i / 100.0)
        Subscription.create user: user, plan_limitation: plan_limitation, plan_amount: amount, stripe_plan_id: plan_id, end_at: Time.at(subscription_end), stripe_subscription_id: subscription_id
        user.update stripe_subscription_id: subscription_id, current_plan_amount: amount, stripe_plan_id: plan_id, subscription_end_at: Time.at(subscription_end)
      when 'customer.subscription.deleted'
        subscription = Subscription.find_by stripe_subscription_id: object["id"]
        stripe_subscription = Stripe::Subscription.retrieve(object["id"])
        # StripeSubscription.cancel_subscription(subscription.user)
        subscription.update subscription_canceled_at: Time.current, end_at: Time.at(stripe_subscription['current_period_end']) if subscription.present?
      end
    end

    render json: {},    status: 200
  end

  def add_credits
    credits_offer = CreditsOffer.find(session[:credits_offer_id])
    CreditsPayment.create credits_offer: credits_offer, user: current_user, credits_add: credits_offer.credits, amount: credits_offer.price, stripe_intent_id: params[:payment_intent_id], stripe_payment_method_id: params[:payment_method_id]
    session.delete(:credits_offer_id)
    respond_to do |format|
      format.any {
        render js: ''
        flash[:success] = I18n.t('other.credits_added')
        flash.keep(:success)
      }
      format.html {
        redirect_to buy_credits_path, flash: {success: I18n.t("other.credits_added")}, method: :get
      }

    end
  end
end
