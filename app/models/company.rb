require 'uri'
require 'securerandom'

class Company < ActiveRecord::Base
  validates :name, presence: true
  validates :name, :url, :company_key, uniqueness: true
  validates :url, format: { with: URI.regexp }

  before_save :generate_company_key

  has_many :jobs
  has_many :employers
  has_many :reviews

  has_attached_file :logo, :styles => { :medium => "300x300>", :small => "150x150>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  private

  def generate_company_key
    self.company_key ||= SecureRandom.hex
  end
end
