class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def already_reviewed?(company_id)
    current_user.reviews.each do |review|
      if review.company_id == company_id
        return true
      end
    end
    false
  end

  helper_method :already_reviewed?
end
