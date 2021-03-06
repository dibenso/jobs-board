class Job < ActiveRecord::Base

  searchkick

	validates :name, :min_wage, :max_wage, :time,
			  :location, :description, :company, :job_category, presence: true

  before_save :default_values

	validates :description, length: { in: 32..4096 }
	validates :time, inclusion: { in: %w(Part Full Contract Seasonal) }
  validate :job_category_included
  validate :max_wage_greater_than_or_equal_to_min_wage

	belongs_to :employer

	has_many :employments
	has_many :users, through: :employments
  has_many :job_applications
  belongs_to :company

  def steady_wage?
    max_wage == min_wage
  end

  def pretty_created_at_time
    self.created_at.to_time.strftime('%B %e at %l:%M %p')
  end

  def job_categories
    ["Accountant", "Actor", "Administrative Assistant / Secretary",
     "Advertising", "Alaska Fishing Jobs", "Aircraft Dispatcher",
     "Aircraft Mechanic", "Airline Pilot", "Animal Careers",
     "Architecture", "Athletic Trainer", "Art Appraiser",
     "Art Auctioneer", "Bank Teller", "Book Publicist",
     "Book Publishing", "Call Center Jobs", "Career Counselor",
     "Consultant", "Computer Programmer", "Criminal Justice",
     "Databases", "Doctor", "EFL Teaching Jobs",
     "EFL Teaching Jobs", "Emergency 911 Dispatcher", "Emergency Medical Services",
     "Emergency 911 Dispatcher", "Financial Advisor", "Flight Attendant",
     "Freelance Editor", "Freelance Editor", "Funeral Director",
     "Fundraiser", "Game Industry", "Genealogist",
     "Government Jobs", "Hair Stylist", "Human Resources",
     "Insurance Agent", "Investment Banker", "Lawyer",
     "Management", "Meteorologist", "Military", "Mobile App Developer",
     "Museum", "Music Conductor", "NASCAR Driver", "Nonprofit Job",
     "Nurse", "Paramedic", "Patient Advocate", "Personal Fitness Trainer",
     "Pharmacist", "Police Officer", "Professional Artist", "Programming",
     "Public Relations", "Psychologist", "Retail", "Sales", "Ski Instructor",
     "School Jobs", "Social Work", "Substitute Teacher", "Teacher",
     "Teaching Abroad", "Teaching Online", "Veterinarian", "Waiter",
     "Web Developer", "Wedding Planner", "Writer / Editor", "Zoo Director"]
  end

  private

  def max_wage_greater_than_or_equal_to_min_wage
    errors.add(:base, "Minimum wage must be less than or equal to maximum wage.") unless min_wage <= max_wage
  end

  def job_category_included
    job_categories.include?(self.job_category)
  end

  def default_values
    self.apply_count ||= 0
  end
end
