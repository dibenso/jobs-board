class EmployersController < ApplicationController
	before_action :authenticate_employer!
  before_action :set_job_application, only: [:show]

  def index
    @jobs = current_employer.jobs.page(params[:page]).per(8)
    @company = Company.new unless current_employer.company
  end

  def job_applications
    @job_applications = current_employer.job_applications
  end

  def show
    ensure_application_belongs_to_employer(@job_application.id)
  end

  def add_company
    if current_employer.company
      flash[:notcie] = 'You already belong to a company'
      redirect_to employers_path
    else
      @company = Company.create(company_params)
      if @company.save
        current_employer.company = @company
        @company.employers << current_employer
        flash[:notice] = "Added company."
        redirect_to employers_path
      else
        flash[:error] = "Failed to saved company."
        render "index"
      end
    end
  end

  def join_company
    if current_employer.company
      flash[:notice] = 'You already belong to a company'
      redirect_to employers_path
    else
      @company = Company.find_by(company_key: params[:company_key])
      if @company
        current_employer.company = @company
        @company.employers << current_employer
        redirect_to employers_path
      else
        flash[:notice] = 'You didn\'t enter a valid company key'
        redirect_to employers_path
      end
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :url, :logo)
  end

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end

  def ensure_application_belongs_to_employer(job_application_id)
    redirect_to root_path unless current_employer.job_applications.exists?(job_application_id)
  end
end
