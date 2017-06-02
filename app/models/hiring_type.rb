class HiringType < ApplicationRecord
  has_many :job_hiring_types, dependent: :destroy
  has_many :jobs, through: :job_hiring_types

  validates :name, presence: true,
    length: {maximum: Settings.hiring_type.max_length_name}
  validates :description, presence: true

  scope :job_hiring_type, ->job_id do
    joins(:jobs).where "job_hiring_types.job_id = ?", job_id
  end
end
