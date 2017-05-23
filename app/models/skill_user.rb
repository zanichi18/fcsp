class SkillUser < ApplicationRecord
  belongs_to :skill
  belongs_to :user

  validates :user_id, presence: true
  validates :skill_id, presence: true

  delegate :name, to: :skill, prefix: true, allow_nil: true
  delegate :description, to: :skill, prefix: true
end
