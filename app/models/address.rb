class Address < ApplicationRecord
  belongs_to :company

  scope :head_office, ->{where head_office: 1}

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :address, presence: true
end
