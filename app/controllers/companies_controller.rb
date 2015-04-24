class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @companies_with_jobs = compinies_with_jobs(1, 8)
    @companies_with_reviews = companies_with_reviews(0, 8)
  end

  def show
    @company = Company.find(params[:id])
    @review = Review.new
  end

  def jobs
    @jobs = Company.find(params[:id]).jobs
  end

  private

  def compinies_with_jobs(greater_than, limit)
    companies = []
    so_far = 0
    Company.all.each do |company|
      if company.jobs.count > greater_than && so_far < limit
        companies << company
        limit += 1
      end
    end
    companies
  end

  def companies_with_reviews(greater_than, limit)
    companies = []
    so_far = 0
    Company.all.each do |company|
      if company.reviews.count > greater_than && so_far < limit
        companies << company
        limit += 1
      end
    end
    companies
  end
end
