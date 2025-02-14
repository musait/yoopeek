class FormatDeliveriesController < ApplicationController
  before_action :set_format_delivery, only: [:show, :edit, :update, :destroy]

  # GET /format_deliveries
  # GET /format_deliveries.json
  def index
    @format_deliveries = FormatDelivery.all
  end

  # GET /format_deliveries/1
  # GET /format_deliveries/1.json
  def show
  end

  # GET /format_deliveries/new
  def new
    @format_delivery = FormatDelivery.new
  end

  # GET /format_deliveries/1/edit
  def edit
  end

  # POST /format_deliveries
  # POST /format_deliveries.json
  def create
    @format_delivery = FormatDelivery.new(format_delivery_params)

    respond_to do |format|
      if @format_delivery.save
        format.html { redirect_to @format_delivery, notice: 'Format delivery was successfully created.' }
        format.json { render :show, status: :created, location: @format_delivery }
      else
        format.html { render :new }
        format.json { render json: @format_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /format_deliveries/1
  # PATCH/PUT /format_deliveries/1.json
  def update
    respond_to do |format|
      if @format_delivery.update(format_delivery_params)
        format.html { redirect_to @format_delivery, notice: 'Format delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @format_delivery }
      else
        format.html { render :edit }
        format.json { render json: @format_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /format_deliveries/1
  # DELETE /format_deliveries/1.json
  def destroy
    @format_delivery.destroy
    respond_to do |format|
      format.html { redirect_to format_deliveries_url, notice: 'Format delivery was successfully destroyed.' }
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
      params.require(:format_delivery).permit(:name)
    end
end
