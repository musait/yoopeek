class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    Notification.set_seen @notifications, "quote", @quote.id
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

  def accept_quote
    render "/checkout/pages-checkout-page-user.html"
  end
  def decline_quote
    @quote = Quote.find(params[:quote])
    @quote.update(status:"declined")
    sender = @quote.receiver
    receiver = @quote.sender
    Notification.create!(message: t('.your_quote_has_been_declined',job: @quote.job.name), quote: @quote, created_for: @quote.class.to_s.underscore, sender: sender, receiver: receiver)
    UserMailer.with(user: @quote.sender, quote: @quote).quote_declined.deliver_later
    redirect_to @quote
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.total_without_vat = @quote.quote_elements.map(&:total).sum
    # Il faut changer la TVA en fonction qu'elle soit française ou suisse

    @quote.total_within_vat = (@quote.total_without_vat * 1.2).round(2)
    @quote.vat = (@quote.total_within_vat - @quote.total_without_vat)
    @quote.job_id = params[:quote][:job_id]
    sender = @quote.sender
    receiver = @quote.receiver
    Notification.create!(message: t('.you_have_received_a_quote',pro: @quote.sender.full_name, job: @quote.job.name), quote: @quote,created_for: @quote.class.to_s.underscore, sender: sender, receiver: receiver)
    respond_to do |format|
      if @quote.save
        UserMailer.with(user: @quote.sender, quote: @quote).new_quote.deliver_later
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
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
