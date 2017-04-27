class UserEducation < ApplicationRecord
  belongs_to :user
  belongs_to :school

  validates :user_id, presence: true
  validates :school_id, presence: true

  scope :sort_by_graduation, ->{order graduation: :desc}

  delegate :name, to: :school, prefix: true, allow_nil: true
end
