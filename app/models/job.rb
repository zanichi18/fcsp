class Job < ApplicationRecord
  belongs_to :company
  has_many :images, as: :imageable

  ATTRIBUTES = [:title, :describe, :type_of_candidates, :who_can_apply,
    :company_id]

  validates :title, presence: true, length: {maximum: Settings.max_length_title}
  validates :describe, presence: true
end
