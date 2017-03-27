class Job < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :images, as: :imageable
  has_many :job_hiring_types, dependent: :destroy
  has_many :hiring_types, through: :job_hiring_types

  ATTRIBUTES = [:title, :describe, :type_of_candidates, :who_can_apply,
    :company_id]

  validates :title, presence: true, length: {maximum: Settings.max_length_title}
  validates :describe, presence: true

  scope :newest, ->{order created_at: :desc}
end
