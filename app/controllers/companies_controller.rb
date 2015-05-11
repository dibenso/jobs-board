class CompaniesController < ApplicationController
  def index
    @company_search = false
    if params[:company_search]
      @company_search = true
      @searched_companies = Company.search(params[:company_search], fields: [:name])
    end
    @companies = Company.page(params[:page]).per(6)
    @companies_with_jobs = compinies_with_jobs(-1, 8)
    @companies_with_reviews = companies_with_reviews(-1, 8)
  end

  def show
    @company = Company.find(params[:id])
    @reviews = @company.reviews
    @review = Review.new
    @random_jobs = @company.jobs.shuffle.first(8)
  end

  def jobs
    Rails.logger.debug "============> #{params}"
    @company = Company.find(params[:id])
    @jobs = @company.jobs
    @job_categories = Job.new.job_categories
  end

  private

  def compinies_with_jobs(greater_than, limit)
    companies = []
    so_far = 0
    Company.all.shuffle.each do |company|
      if company.jobs.count > greater_than && so_far < limit
        companies << company
        so_far += 1
      end
    end
    companies
  end

  def companies_with_reviews(greater_than, limit)
    companies = []
    so_far = 0
    Company.all.shuffle.each do |company|
      if company.reviews.count > greater_than && so_far < limit
        companies << company
        so_far += 1
      end
    end
    companies
  end
end
