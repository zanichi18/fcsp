class Address < ApplicationRecord
  belongs_to :company

  scope :head_office, ->{where head_office: 1}
end
