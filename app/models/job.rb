class Job < ActiveRecord::Base
	validates :name, :min_wage, :max_wage, :time,
			  :location, :description, :company, presence: true

  before_save :default_values

	validates :description, length: { in: 32..4096 }
	validates :time, inclusion: { in: %w(Part Full Contract Seasonal) }

	belongs_to :employer

	has_many :employments
	has_many :users, through: :employments
  has_many :job_applications

  private

  def default_values
    self.apply_count ||= 0
  end
end
