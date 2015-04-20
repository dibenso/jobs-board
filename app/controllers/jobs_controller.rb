class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employer!, except: [:index, :show]
  before_action :ensure_owner_of_job, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:apply]
  before_action :ensure_employer_belongs_to_company, only: [:new, :create]

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
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
