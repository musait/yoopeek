class Admin::PlanLimitationsController <  AdminController
  before_action :set_plan_limitation, only: [:show, :edit, :update, :destroy]

  # GET /plan_limitations
  # GET /plan_limitations.json
  def index
    @plan_limitations = PlanLimitation.order(:show_order).all
    if @plan_limitations.blank?
      PlanLimitation.free_limitation
      PlanLimitation.classic_limitation
      PlanLimitation.premium_limitation
      @plan_limitations = PlanLimitation.order(:show_order).all
    end
  end

  # GET /plan_limitations/1
  # GET /plan_limitations/1.json
  def show
  end

  # GET /plan_limitations/new
  def new
    @plan_limitation = PlanLimitation.new
  end

  # GET /plan_limitations/1/edit
  def edit
  end

  # POST /plan_limitations
  # POST /plan_limitations.json
  def create
    @plan_limitation = PlanLimitation.new(plan_limitation_params)
    @plan_limitation.optional_services = params[:plan_limitation][:optional_services][0].split(' ')
    respond_to do |format|
      if @plan_limitation.save
        format.html { redirect_to @plan_limitation, notice: 'PlanLimitation was successfully created.' }
        format.json { render :show, status: :created, location: @plan_limitation }
      else
        format.html { render :new }
        format.json { render json: @plan_limitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plan_limitations/1
  # PATCH/PUT /plan_limitations/1.json
  def update
    respond_to do |format|
      if @plan_limitation.update(plan_limitation_params)
        format.html { redirect_to admin_plan_limitations_path, notice: 'PlanLimitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan_limitation }
      else
        format.html { render :edit }
        format.json { render json: @plan_limitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plan_limitations/1
  # DELETE /plan_limitations/1.json
  def destroy
    # @plan_limitation.destroy
    # respond_to do |format|
    #   format.html { redirect_to admin_plan_limitations_url, notice: 'PlanLimitation was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan_limitation
      @plan_limitation = PlanLimitation.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_limitation_params
      params.require(:plan_limitation).permit(:name, :label, :description, :price_per_month, :commission_per_service, :commission_type, :nb_answer, :nb_answer_type, :limit_portfolio, :limit_portfolio_content, :have_badge, :have_status, :stripe_plan_id)
    end
end
