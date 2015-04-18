class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_employer!, only: [:destroy]

  def new
    @job = Job.find(params[:job_id])
    ensure_user_has_not_already_applied(@job.id)
    unless @job
      flash[:notice] = "Please use the links provided."
      redirect_to root_path
    end
    @job_application = JobApplication.new
  end

  def create
    @job_application = JobApplication.new(job_application_params)
    @job = Job.find(params[:job_id])
    ensure_user_has_not_already_applied(@job.id)
    if @job.employer.jobs.exists?(@job.id)
      current_user.jobs << @job
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
    redirect_to root_path unless current_employer.job_applications.exists?(@job_application.id)
    current_employer.job_applications.delete(@job_application.id)
    respond_to do |format|
      format.html { redirect_to job_applications_url, notice: 'Job application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def ensure_user_has_not_already_applied(job_id)
      if current_user.jobs.exists?(job_id)
        flash[:notice] = "You have already applied to this job."
        redirect_to root_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:first_name, :last_name, :cover_letter)
    end
end
