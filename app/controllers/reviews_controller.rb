class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = current_user.reviews
  end

  def edit
    @review = Review.find(params[:id])
    ensure_review_belongs_to_user(@review.id)
  end

  def create
    @review = Review.create(review_params)
    company = Company.find(params[:company_id])
    if already_reviewed?(company.id)
      flash[:notice] = 'Already reviewed.'
      redirect_to back
    else
      @review.company_id = company.id
      @review.user_id = current_user.id
      current_user.reviews << @review
      company.reviews << @review
      if @review.save
        flash[:notice] = 'Created review successfully.'
        redirect_to :back
      else
        flash[:error] = 'Failed to save review'
        redirect_to :back
      end
    end
  end

  def update
    @review = Review.find(params[:id])
    ensure_review_belongs_to_user(@review.id)
    @review.update(review_params)
    if @review.save
      flash[:notice] = 'Updated review successfully.'
      redirect_to companies_path
    else
      flash[:error] = 'Failed to update review'
      redirect_to root_path
    end
  end

  def destroy
    @review = Review.find(params[:id])
    ensure_review_belongs_to_user(@review.id)
    @review.destroy
    flash[:notice] = 'Review was successfully destroyed'
    redirect_to companies_path
  end

  private

  def ensure_review_belongs_to_user(review_id)
    unless current_user.reviews.exists?(review_id)
      redirect_to root_path
    end
  end

  def review_params
    params.require(:review).permit(:content, :pros, :cons)
  end
end
