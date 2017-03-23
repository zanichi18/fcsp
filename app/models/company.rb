class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :benefits, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :user, through: :employees
  has_many :teams, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :images, as: :imageable
  has_many :team_introductions, as: :team_target_type
  has_many :users, through: :employees
  has_many :company_industries
  has_many :industries, through: :company_industries

  ATTRIBUTES = [:name, :website, :introduction, :founder, :country,
    :company_size, :founder_on]

  validates :name, presence: true,
    length: {maximum: Settings.company.max_length_name}
  validates :website, presence: true
  validates :company_size, numericality: {greater_than: 0}
end
