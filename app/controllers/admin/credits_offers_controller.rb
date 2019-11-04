class Admin::CreditsOffersController <  AdminController
  before_action :set_credits_offer, only: [:show, :edit, :update, :destroy]

  # GET /credits_offers
  # GET /credits_offers.json
  def index
    @credits_offers = CreditsOffer.order(:price).all
  end

  # GET /credits_offers/1
  # GET /credits_offers/1.json
  def show
  end

  # GET /credits_offers/new
  def new
    @credits_offer = CreditsOffer.new
  end

  # GET /credits_offers/1/edit
  def edit
  end

  # POST /credits_offers
  # POST /credits_offers.json
  def create
    @credits_offer = CreditsOffer.new(credits_offer_params)
    respond_to do |format|
      if @credits_offer.save
        format.html { redirect_to @credits_offer, notice: 'CreditsOffer was successfully created.' }
        format.json { render :show, status: :created, location: @credits_offer }
      else
        format.html { render :new }
        format.json { render json: @credits_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credits_offers/1
  # PATCH/PUT /credits_offers/1.json
  def update
    respond_to do |format|
      if @credits_offer.update(credits_offer_params)
        format.html { redirect_to admin_credits_offers_path, notice: 'CreditsOffer was successfully updated.' }
        format.json { render :show, status: :ok, location: @credits_offer }
      else
        format.html { render :edit }
        format.json { render json: @credits_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credits_offers/1
  # DELETE /credits_offers/1.json
  def destroy
    @credits_offer.destroy
    respond_to do |format|
      format.html { redirect_to admin_credits_offers_url, notice: 'CreditsOffer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credits_offer
      @credits_offer = CreditsOffer.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def credits_offer_params
      params.require(:credits_offer).permit(:price, :credits, :reduction)
    end
end
