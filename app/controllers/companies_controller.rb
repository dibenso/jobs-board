class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def jobs
    @jobs = Company.find(params[:id]).jobs
  end
end
