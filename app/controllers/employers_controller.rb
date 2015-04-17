class EmployersController < ApplicationController
	before_action :authenticate_employer!

  def index
    @jobs = current_employer.jobs
  end
end
