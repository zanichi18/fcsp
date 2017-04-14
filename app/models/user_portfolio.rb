class UserPortfolio < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {
    minimum: Settings.user_portfolios.title_min,
    maximum: Settings.user_portfolios.title_max
  }
  validates :url, presence: true, url: true
  validates :time, presence: true
  validates :description, presence: true, length: {
    minimum: Settings.user_portfolios.description_min,
    maximum: Settings.user_portfolios.description_max
  }
  validates :user_id, presence: true
end
