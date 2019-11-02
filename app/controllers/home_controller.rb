class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :search_result]
  def index
  end
  def search_result
    if params[:search].present?
      @workers = Worker.joins(:categories).where(categories: {name: params[:name]})
    else
      @workers = Worker.paginate(page: params[:page], per_page: params[:per_page])
    end

  end
  def checkout_credit
    case params[:id].to_s
    when "1"
      @amount = 15
      @credits = 20
    when "2"
      @amount = 35
      @credits = 50
    when "3"
      @amount = 65
      @credits = 100
    when "4"
      @amount = 300
      @credits = 500
    when "5"
      @amount = 500
      @credits = 1000
    else
      @amount = 8
      @credits = 10
    end
    @intent = Stripe::PaymentIntent.create({
      amount: @amount * 100,
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
    session[:credits] = @credits
    session[:amount] = @amount
  end

  def add_credits
    CreditsPayment.create user: current_user, credits_add: session[:credits].to_i, amount: session[:amount], stripe_intent_id: params[:payment_intent_id], stripe_payment_method_id: params[:payment_method_id]
    session.delete(:credits)
    session.delete(:amount)
    respond_to do |format|
      format.any {
        # Charge à notre code d'implémenter le to_xls
        render js: ''
      }
      format.html {
        redirect_to buy_credits_path, flash: {success: I18n.t("other.credits_added")}, method: :get
      }

    end
  end
end
