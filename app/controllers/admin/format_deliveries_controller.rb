class Admin::FormatDeliveriesController < AdminController
  before_action :set_format_delivery, only: [:show, :edit, :update, :destroy]

  # GET /admin/format_deliveries
  # GET /admin/format_deliveries.json
  def index
    @format_deliveries = FormatDelivery.all
    @format_delivery = FormatDelivery.new
  end

  # GET /admin/format_deliveries/1
  # GET /admin/format_deliveries/1.json
  def show
  end

  # GET /admin/format_deliveries/new
  def new
    @format_delivery = FormatDelivery.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /admin/format_deliveries/1/edit
  def edit
    @format_delivery = FormatDelivery.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /admin/format_deliveries
  # POST /admin/format_deliveries.json
  def create
    @format_delivery = FormatDelivery.new(format_delivery_params)

    respond_to do |format|
      if @format_delivery.save
        format.html { redirect_to admin_format_deliveries_path, notice: 'Le format de livraison a été crée avec succès' }
        format.json { render :show, status: :created, location: @format_delivery }
      else
        format.html { render :new }
        format.json { render json: @format_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/format_deliveries/1
  # PATCH/PUT /admin/format_deliveries/1.json
  def update
    respond_to do |format|
      if @format_delivery.update(format_delivery_params)
        format.html { redirect_to admin_format_deliveries_path, notice: 'Le format de livraison a été mis à jour avec succès' }
        format.json { render :show, status: :ok, location: @format_delivery }
      else
        format.html { render :edit }
        format.json { render json: @format_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/format_deliveries/1
  # DELETE /admin/format_deliveries/1.json
  def destroy
    @format_delivery.destroy
    respond_to do |format|
      format.html { redirect_to admin_format_deliveries_url, notice: 'Le format de livraison a été supprimé avec succès' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_format_delivery
      @format_delivery = FormatDelivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def format_delivery_params
      params.require(:format_delivery).permit(:id,:name)
    end
end
