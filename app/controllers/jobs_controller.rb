class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employer!, except: [:index, :show]
  before_action :ensure_owner_of_job, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:apply]
  before_action :ensure_employer_belongs_to_company, only: [:new, :create]

  # GET /jobs
  # GET /jobs.json
  def index
    @full_time_jobs = Job.where(time: 'Full').shuffle.first(12)
    @part_time_jobs = Job.where(time: 'Part').shuffle.first(12)
    @seasonal_jobs = Job.where(time: 'Seasonal').shuffle.first(12)
    @contract_jobs = Job.where(time: 'Contract').shuffle.first(12)
    @popular_jobs = Job.all.sort_by { |j| -j.apply_count }.first(48).shuffle.first(12)
    @recent_jobs = Job.all.order('created_at DESC').first(50).shuffle.first(12)
    @job_categories = Job.new.job_categories
    @searched_jobs = []
    @searched = false
    if params[:search]
      @searched = true
      @searched_jobs = search_jobs(search_params(params[:search]))
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job_application = JobApplication.new
    # Use reject here later
    @similar_jobs = Job.where(company_id: @job.company_id, job_category: @job.job_category, location: @job.location).limit(8).shuffle
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)
    @job.company = current_employer.company

    respond_to do |format|
      if @job.save
        current_employer.jobs << @job
        current_employer.company.jobs << @job
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

  def search_jobs(params)
    job_name = params[:name]
    return unless ['day', 'week', 'month', 'year'].include?(params[:created_at]) && params[:created_at]
    params.delete(:name)
    params[:created_at] = {gte: eval("1.#{params[:created_at]}.ago")} if params[:created_at]
    if job_name
      Job.search(job_name, order: {apply_count: :desc}, where: params.permit(allowed_search_params))
    else
      Job.search(order: {apply_count: :desc}, where: params.permit(allowed_search_params))
    end
  end

  def allowed_search_params
    ['name', 'time', 'job_category', 'created_at']
  end

  def search_params(params)
    params.delete_if { |key, val| val == '' || !allowed_search_params.include?(key.to_s) }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:name, :min_wage, :max_wage, :time, :location, :description, :job_category)
  end

  def ensure_owner_of_job
    unless @job.employer.id == current_employer.id
      redirect_to root_path
    end
  end

  def ensure_employer_belongs_to_company
    unless current_employer.company
      flash[:notice] = "Join or create a company before creating new jobs."
      redirect_to employers_path
    end
  end
end
