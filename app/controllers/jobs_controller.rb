class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    if current_user.is_worker
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

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    Notification.set_seen @notifications, "job", @job.id
    @workers = Worker.includes(:category).where(categories: {name: @job.category.name})
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  def worker_jobs
    @jobs = Job.where(worker_id: current_user.id).page(params[:page]).per(5)
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.optional_services = params[:job][:optional_services][0].split(' ')
    @job.status = "created"
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
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
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
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
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
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
