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
    @company = Company.find(params[:id])
    @jobs = @company.jobs.page(params[:page]).per(9)
    @job_categories = Job.new.job_categories
    @searched = false
    @searched_jobs = []
    if (params.keys & allowed_search_params).any?
      @searched = true
      @searched_jobs = search_jobs(params, @company)
    end
  end

  private

  def search_jobs(params, company)
    jobs = company.jobs
    if params[:created_at]
      created_at = params[:created_at]
      params.delete(:created_at)
      search_params(params)
      case created_at
      when 'week'
        params[:created_at] = 1.week.ago..Time.now
        jobs.search(where: params)
      when 'month'
        params[:created_at] = 1.year.ago..Time.now
        jobs.search(where: params)
      when 'year'
        params[:created_at] = 1.year.ago..Time.now
        jobs.search(where: params)
      else
        jobs.search(where: params)
      end
    else
      jobs.search(where: params)
    end
  end

  def search_params(params)
    params.delete_if { |key, val| val == '' || !allowed_search_params.include?(key.to_s) }
  end

  def allowed_search_params
    ['name', 'time', 'job_category', 'created_at']
  end


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
