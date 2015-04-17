class Job < ActiveRecord::Base
	validates :name, :min_wage, :max_wage, :time,
			  :location, :description, presence: true

	validates :description, length: { in: 32..4096 }
	validates :time, inclusion: { in: %w(Part Full Contract Seasonal) }

	belongs_to :employer

	has_many :employments
	has_many :users, through: :employments
end
