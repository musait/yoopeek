class Admin::FormatDeliveriesController < ApplicationController
  before_action :set_admin_format_delivery, only: [:show, :edit, :update, :destroy]

  # GET /admin/format_deliveries
  # GET /admin/format_deliveries.json
  def index
    @admin_format_deliveries = Admin::FormatDelivery.all
  end

  # GET /admin/format_deliveries/1
  # GET /admin/format_deliveries/1.json
  def show
  end

  # GET /admin/format_deliveries/new
  def new
    @admin_format_delivery = Admin::FormatDelivery.new
  end

  # GET /admin/format_deliveries/1/edit
  def edit
  end

  # POST /admin/format_deliveries
  # POST /admin/format_deliveries.json
  def create
    @admin_format_delivery = Admin::FormatDelivery.new(admin_format_delivery_params)

    respond_to do |format|
      if @admin_format_delivery.save
        format.html { redirect_to @admin_format_delivery, notice: 'Format delivery was successfully created.' }
        format.json { render :show, status: :created, location: @admin_format_delivery }
      else
        format.html { render :new }
        format.json { render json: @admin_format_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/format_deliveries/1
  # PATCH/PUT /admin/format_deliveries/1.json
  def update
    respond_to do |format|
      if @admin_format_delivery.update(admin_format_delivery_params)
        format.html { redirect_to @admin_format_delivery, notice: 'Format delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_format_delivery }
      else
        format.html { render :edit }
        format.json { render json: @admin_format_delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/format_deliveries/1
  # DELETE /admin/format_deliveries/1.json
  def destroy
    @admin_format_delivery.destroy
    respond_to do |format|
      format.html { redirect_to admin_format_deliveries_url, notice: 'Format delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_format_delivery
      @admin_format_delivery = Admin::FormatDelivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_format_delivery_params
      params.require(:admin_format_delivery).permit(:name)
    end
end
