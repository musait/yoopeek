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
    @plan_limitation = PlanLimitation.find(params[:plan_limitation_id])
    if @plan_limitation.stripe_plan_id.present?
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
      session[:plan_limitation_id] = @plan_limitation.id
    else
      redirect_back fallback_location: root_path, flash: {info: I18n.t("other.subscription_have_no_plan")}
    end
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

  def invoices
    @subscriptions = current_user.subscriptions
  end

  def invoice
    @subscription = Subscription.find(params[:id])
    respond_to do |format|
      format.pdf do
        @customer = @subscription.user
        @total = @subscription.plan_amount
        @amount_without_taxes = @total / 1.2
        @taxes = @amount_without_taxes * 20 / 100
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
