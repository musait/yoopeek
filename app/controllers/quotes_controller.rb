class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy, :accept, :decline, :pay]


  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.where("receiver_id = ? OR sender_id = ?",current_user.id,current_user.id)
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    Notification.set_seen @notifications, "quote", @quote.id
    count_notification
  end

  def show_test
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.quote_elements.build
    @job = Job.find(params[:job_id])
  end

  # GET /quotes/1/edit
  def edit
  end

  def accept
    if @quote.sender.stripe_account_id.present?
      @quote.update(status:"accepted")
      @total_without_vat = @quote.total_without_vat
      @vat = @quote.vat
      @total_within_vat = @quote.total_within_vat
      worker = @quote.sender
      stripe_total = (  @total_within_vat * 100).to_i
      worker_plan = worker.current_plan
      if worker_plan.commission_type == "%"
        commission_collected = (  @total_within_vat * worker_plan.commission_per_service / 100)
      else
        commission_collected = (worker_plan.commission_per_service)
      end
      @intent = Stripe::PaymentIntent.create({
        amount: stripe_total,
        currency: 'eur',
        on_behalf_of: worker.stripe_account_id,
        transfer_data: {
          destination: worker.stripe_account_id,
          amount: stripe_total - (commission_collected * 100).to_i,
        }
      })
      session[:payment_intent_id] = @intent.id
      session[:commission_collected] = commission_collected
    else
      redirect_back fallback_location: root_path, flash: {error: I18n.t("no_stripe_account")}
    end
  end

  def pay
    @intent = Stripe::PaymentIntent.retrieve(
      session[:payment_intent_id],
    )
    if @intent.status == "succeeded"
      @quote.update(status:"paid", commission_collected: session[:commission_collected], stripe_intent_id: @intent.id)
      @quote.job.update(worker_id: @quote.sender.id,status:"in_progress",sold_at: @intent.amount/100)
      session.delete(:payment_intent_id)
      session.delete(:commission_collected)
      respond_to do |format|
        format.any {
          render js: ''
          flash[:success] = I18n.t("other.payment_done")
          flash.keep(:success)
        }
        format.html {
          redirect_back fallback_location: root_path, flash: {success: I18n.t("other.payment_done")}, method: :get
        }
      end
    else
      redirect_back fallback_location: root_path, flash: {success: I18n.t("other.subscription_changed")}
    end
  end
  def decline
    @quote = Quote.find(params[:quote])
    @quote.update(status:"declined")
    redirect_to @quote
  end

  # POST /quotes
  # POST /quotes.json
  def create

    @quote = Quote.new(quote_params)
    sender = @quote.sender
    receiver = @quote.receiver
    if sender.company.present?
      @quote.total_without_vat = @quote.quote_elements.sum(&:total)
      if sender.company.is_subject_to_vat?
        # Il faut changer la TVA en fonction qu'elle soit française ou suisse
        @quote.total_within_vat = (@quote.total_without_vat * 1.2).round(2)
        @quote.vat = (@quote.total_within_vat - @quote.total_without_vat)
      else
        @quote.total_within_vat = @quote.total_without_vat
        @quote.vat = 0
      end
      @quote.job_id = params[:quote][:job_id]
      respond_to do |format|
        if @quote.save
          format.html { redirect_to @quote, notice: t('.quote_created') }
          format.json { render :show, status: :created, location: @quote }
        else
          @job = @quote.job

          format.html { render :new  }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_user_registration_path(id:sender.id), notice: t('.to_create_a_quote_you_must_have_a_company')
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:name,:job_id,:quote_number,:sender_id, :receiver_id,:quote_elements_attributes => [ :id, :content,:quantity,:total, :price, :_destroy ])
    end
end
