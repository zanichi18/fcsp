class Award < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :time, presence: true
end
