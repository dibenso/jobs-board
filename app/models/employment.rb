class Employment < ActiveRecord::Base
	belongs_to :job
	belongs_to :user
end
