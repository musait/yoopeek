class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search_result]
  def index
  end
  def search_result
    @workers = []
    if params[:category].present?
      @category = Category.find(params[:category])
      @workers = Worker.joins(:category).where(categories: {name: @category.name}).page(params[:page])
    else
      @workers = Worker.all
    end
    if params[:city].present?
      @workers = @workers.joins(:company => [:address]).where(addresses: {city: params[:city].split(',')[0]}).page(params[:page])

    end
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

  def buy_credits
    @credits_offers = CreditsOffer.order(:price, reduction: :desc).all
  end

  def add_credits
    credits_offer = CreditsOffer.find(session[:credits_offer_id])
    CreditsPayment.create user: current_user, credits_add: credits_offer.credits, amount: credits_offer.price, stripe_intent_id: params[:payment_intent_id], stripe_payment_method_id: params[:payment_method_id]
    session.delete(:credits_offer_id)
    respond_to do |format|
      format.any {
        render js: ''
      }
      format.html {
        redirect_to buy_credits_path, flash: {success: I18n.t("other.credits_added")}, method: :get
      }

    end
  end
end
