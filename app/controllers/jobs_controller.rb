class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :finished, :invoice]

  # GET /jobs
  # GET /jobs.json
  def index
    if current_user.worker?
      if params[:filter].present?
        @jobs = Job.joins(:category).where(categories: {id: params[:filter]}).where(status: "created").page(params[:page])
      else
        @jobs = Job.where(status: "created").page(params[:page])
      end
    else
      if params[:filter].present?
        @jobs = Job.where(customer_id:current_user.id).where(status: params[:filter]).page(params[:page])
      else
        @jobs = Job.where(customer_id:current_user.id).page(params[:page])
      end
    end
  end
  def invoice
    @invoice = @job.invoice
    @customer = @job.customer
    if @invoice.present?
      respond_to do |format|
        format.pdf do
          @invoice_elements = @invoice.invoice_elements
          @worker = @invoice.sender
          @worker_company = @worker.company
          @total = @invoice.total
          @commission = @invoice.commission_collected
          @amount_without_taxes = (@total / 1.2)
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
      UserMailer.with(user: @customer, invoice: @invoice).new_invoice.deliver_now
    else
      redirect_back fallback_location: root_path, flash:{error: I18n.t('job_without_invoice')}
    end
  end
  def finished
    quote = @job.current_quote
    if quote.present?
      if current_user.worker? && !@job.completed_by_worker?
        @job.completed_by_worker!
        redirect_back fallback_location: @job, flash: {success: I18n.t("mission_finished")}
      elsif current_user.customer? && !@job.completed_by_customer?
        @job.completed_by_customer!
        quote.create_invoice
        redirect_back fallback_location: @job, flash: {success: I18n.t("mission_finished")}
      else
        redirect_back fallback_location: root_path, flash: {error: I18n.t("action_not_enable")}
      end
    else
      redirect_back fallback_location: root_path, flash: {error: I18n.t("no_quote_created")}
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    Notification.set_seen @notifications, "job", @job.id
    count_notification
    @workers = Worker.includes(:category).where(categories: {name: @job.category.name})
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @categories = Category.all
    @category = Category.find_by(id: @job.category_id) || @categories.first
    @subcategories = @category.subcategories || Subcategory.all
  end
  def init_categories
    @categories = Category.all
    @category = Category.find_by(id: @job.category_id) || @categories.first
    @subcategories = @category.subcategories || Subcategory.all

  end
  # GET /jobs/1/edit
  def edit
    init_categories
  end

  def worker_jobs
    if params[:filter].present?
      @jobs = Job.where(worker_id: current_user.id).where(status: params[:filter]).page(params[:page])
    else
      @jobs = Job.where("worker_id = ?",current_user.id).page(params[:page])
    end
  end

  # POST /jobs
  # POST /jobs.json
  def create

    @job = Job.new(job_params)
    @job.optional_services = params[:job][:optional_services][0].split(' ')
    @job.status = "created"

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: t('.job_created') }
        format.json { render :show, status: :created, location: @job }
      else
        init_categories
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: t('.job_updated') }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: t('.job_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
        @job = Job.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:name, :description,:localisation,:min_price,:max_price,:min_time,:user_id,:category_id,:customer_id,:format_delivery_id, :date_delivery,:subcategory_id,:max_time,:optional_services => [])
    end
end
