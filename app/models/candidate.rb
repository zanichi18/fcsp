class Candidate < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :user_id, presence: true
  validates :job_id, presence: true

  delegate :title, to: :job, prefix: true
  delegate :email, to: :user, prefix: true

  scope :in_job, ->job_id{where job_id: job_id}
end
