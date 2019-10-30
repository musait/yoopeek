class SubscriptionsController < UsersController
  def index
    @plan_limitations = PlanLimitation.order(:show_order).all
    if @plan_limitations.blank?
      PlanLimitation.free_limitation
      PlanLimitation.classic_limitation
      PlanLimitation.premium_limitation
      @plan_limitations = PlanLimitation.order(:show_order).all
    end
  end
  def new
    @intent = Stripe::SetupIntent.create({
      usage: 'on_session', # The default usage is off_session
    })
    if current_user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        :email => current_user.email
      )
      current_user.update stripe_customer_id: customer.id
    end
    @plan_limitation = PlanLimitation.find(params[:plan_limitation_id])
    session[:plan_limitation_id] = @plan_limitation.id
  end
  def free_plan
    plan_limitation = PlanLimitation.find(params[:id])
    StripeSubscription.cancel_subscription current_user
    redirect_back fallback_location: users_subscription_path
  end
  def create
    @plan_limitation = PlanLimitation.find(session[:plan_limitation_id].to_s)
    if current_user.stripe_customer_id.present?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        :email => current_user.email
      )
      current_user.update stripe_customer_id: customer.id
    end
    # customer.sources.create(source: generate_token).id
    # token = generate_token
    # if token.present?

    payment_method = Stripe::PaymentMethod.attach(
      params['payment_method_id'],
      {
        customer: current_user.stripe_customer_id,
      }
    )
    begin
      current_user.update last_stripe_payment_method_id: params['payment_method_id']
      pay_plan @plan_limitation
    rescue => e
      if e.try('code').present?
        flash[:alert] = I18n.translate("stripe.errors.#{e.code}")
        flash[:alert] = I18n.translate("stripe.errors.#{e.code}")
      else
        p 'error', e
        flash[:alert] = 'Il y a eu un probleme'
      end
      redirect_back fallback_location: subscriptions_path
    end
    # else
    #   redirect_back fallback_location: users_subscription_path
    # end
  end
  private
  def pay_plan plan_limitation
    plan_id = plan_limitation.stripe_plan_id
    StripeSubscription.create current_user, plan_id, @plan_limitation
    session.delete(:plan_limitation_id)
    respond_to do |format|
      format.any {
        # Charge à notre code d'implémenter le to_xls
        render js: ''
      }
      format.html {
        redirect_to subscriptions_path, flash: {success: I18n.t("other.subscription_changed")}, method: :get
      }

    end
  end
  def generate_token
    begin
    Stripe::Token.create(
      card: {
        number: params[:card_number],
        exp_month: params[:card_month],
        exp_year: params[:card_year],
        cvc: params[:card_cvc]
      }
    )
    rescue => e
      flash[:error] = I18n.translate("stripe.errors.#{e.code}")
      false
    end
  end
end
