class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :user_id, presence: true
  validates :job_id, presence: true
end
