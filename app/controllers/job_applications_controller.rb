class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_employer!, only: [:destroy]

  def new
    @job = Job.find(params[:job_id])
    unless @job
      flash[:notice] = "Please use the links provided."
      redirect_to root_path
    end
    @job_application = JobApplication.new
  end

  def create
    @job_application = JobApplication.new(job_application_params)
    @job = Job.find(params[:job_id])
    if @job.employer.jobs.exists?(@job.id)
      @job_application.job = @job
      @job_application.user = current_user
      @job_application.employer = @job.employer
    else
      render "new"
    end

    respond_to do |format|
      if @job_application.save
        format.html { redirect_to root_path, notice: 'Job application was successfully created.' }
        format.json { render :show, status: :created, location: @job_application }
      else
        format.html { render :new }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to job_applications_url, notice: 'Job application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:first_name, :last_name, :cover_letter)
    end
end
