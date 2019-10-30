class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]

  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = Portfolio.all
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    @portfolio = Portfolio.find(params[:id])
  end

  # GET /portfolios/new
  def new
    @portfolio = Portfolio.new
    @jobs = Job.where(worker_id: current_user.id)
  end

  # GET /portfolios/1/edit
  def edit
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @portfolio = Portfolio.new(portfolio_params.merge!(user_id: current_user.id))
      if @portfolio.save
        save_pictures
        render json: { message: "success", portfolioId: @portfolio.id }, status: 200
      else
        render json: { error: @portfolio.errors.values.join(",")}, status: 400
      end
  end

  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update

    if @portfolio.update(portfolio_params)
      save_pictures
      render json: { message: "success", portfolioId: @portfolio.id }, status: 200
    else
      render json: { error: @portfolio.errors.values.join(",")}, status: 400
    end

  end
  def delete_image_attachment
    @portfolio_image = ActiveStorage::Attachment.find(params[:id])
    @portfolio_image.purge
    redirect_back(fallback_location: request.referer)
  end
  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.js { flash[:notice] = t('.destroyed_with_success')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    def save_pictures
      if params[:portfolio][:picture]
        params[:portfolio][:picture].each do |image|
          @portfolio.picture.attach(image.pop)
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
        params.require(:portfolio).permit(:id, :job_id)
    end
end
