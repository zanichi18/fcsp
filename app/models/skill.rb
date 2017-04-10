class Skill < ApplicationRecord
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills
  has_many :skill_users, dependent: :destroy
  has_many :users, through: :skill_users

  validates :name, presence: true, uniqueness: true,
    length: {maximum: Settings.max_length_title}
end
