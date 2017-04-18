class Company < ApplicationRecord
  acts_as_followable
  has_many :jobs, dependent: :destroy
  has_many :candidates, through: :jobs
  has_many :candidate_users, through: :candidates, source: :user
  has_many :benefits, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :users, through: :employees
  has_many :company_industries, dependent: :destroy
  has_many :industries, through: :company_industries
  has_many :team_introductions, as: :team_target

  ATTRIBUTES = [:name, :website, :introduction, :founder, :country,
    :company_size, :founder_on, addresses_attributes: [:id, :address,
    :longtitude, :latitude, :head_office], industry_ids: [],
    images_attributes: [:id, :imageable_id, :imageable_type,
      :picture, :caption]]

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, presence: true,
    length: {maximum: Settings.company.max_length_name}
  validates :website, presence: true
  validates :company_size, numericality: {greater_than: 0}
end
