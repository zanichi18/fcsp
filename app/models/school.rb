class School < ApplicationRecord
  has_many :user_educations
  has_many :users, through: :user_educations, source: :user

  validates :name, presence: true, length: {
    maximum: Settings.user_educations.school_max
  }

  def student_count
    self.users.count
  end
end
