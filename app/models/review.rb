class Review < ActiveRecord::Base
  belongs_to :user
  has_one :company
end
