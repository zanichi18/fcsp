class UserEducation < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :school, presence: true, length: {
    minimum: Settings.user_educations.school_min,
    maximum: Settings.user_educations.school_max
  }
  validates :major, presence: true, length: {
    minimum: Settings.user_educations.major_min,
    maximum: Settings.user_educations.major_max
  }
  validates :graduation, presence: true
  validates :description, presence: true, length: {
    minimum: Settings.user_educations.description_min,
    maximum: Settings.user_educations.description_max
  }
end
