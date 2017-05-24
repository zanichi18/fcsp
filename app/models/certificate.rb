class Certificate < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
    length: {maximum: Settings.certificate.max_length_name}
  validates :qualified_time, presence: true
  validates :qualified_organization, presence: true,
    length: {maximum: Settings.certificate.max_length_qualified_organization}

  scope :newest, ->{order created_at: :desc}
end
