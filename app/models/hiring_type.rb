class HiringType < ApplicationRecord
  has_many :job_hiring_types
  has_many :jobs, through: :job_hiring_types

  validates :name, presence: true,
    length: {maximum: Settings.hiring_type.max_length_name}
  validates :description, presence: true
end
