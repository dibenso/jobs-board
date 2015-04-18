class EmployersController < ApplicationController
	before_action :authenticate_employer!
  before_action :set_job_application, only: [:show]

  def index
    @jobs = current_employer.jobs
  end

  def job_applications
    @job_applications = current_employer.job_applications
  end

  def show
    ensure_application_belongs_to_employer(@job_application.id)
  end

  private

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end

  def ensure_application_belongs_to_employer(job_application_id)
    redirect_to root_path unless current_employer.job_applications.exists?(job_application_id)
  end
end
