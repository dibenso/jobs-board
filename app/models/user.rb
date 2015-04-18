class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true
  validates :username, length: { in: 6..32 }
  validates :username, presence: true

  has_many :employments
  has_many :jobs, through: :employments
  has_many :job_applications
end
