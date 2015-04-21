class Review < ActiveRecord::Base
  validates :content, :pros, :cons, :user_id, :company_id, presence: true
  validates :content, :pros, :cons, length: { in: 32..4096 }

  belongs_to :user
  has_one :company
end
