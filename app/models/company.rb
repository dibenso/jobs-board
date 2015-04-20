require 'uri'
require 'securerandom'

class Company < ActiveRecord::Base
  validates :name, presence: true
  validates :name, :url, :company_key, uniqueness: true
  validates :url, format: { with: URI.regexp }

  before_save :generate_company_key

  has_many :jobs
  has_many :employers

  private

  def generate_company_key
    self.company_key ||= SecureRandom.hex
  end
end
