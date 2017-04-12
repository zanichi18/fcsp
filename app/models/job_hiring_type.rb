class JobHiringType < ApplicationRecord
  belongs_to :job
  belongs_to :hiring_type

  scope :by_hiring_type, ->id do
    where(hiring_type_id: id).pluck :job_id
  end
end
