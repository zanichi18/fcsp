class UserPortfolio < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy

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

  scope :newest, ->{order created_at: :desc}

  accepts_nested_attributes_for :images, allow_destroy: true
end
