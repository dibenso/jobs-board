class JobApplication < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :cover_letter, length: { in: 32..4096 }
  validates :phone_number, format: { with: /(^\d{3}-\d{3}-\d{4}$)|(^\d{10}$)/ }

  belongs_to :job
  belongs_to :user
  belongs_to :employer
end
