class UserWork < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  validates_date :end_time, after: :start_time, if: :check_time_present

  delegate :name, to: :organization, prefix: true, allow_nil: true
  enum status: {full_time: 0, part_time: 1, internship: 2}

  scope :related_org_ids_of, ->org{where user_id: org.users.pluck(:id)}

  private

  def check_time_present
    start_time.present? && end_time.present?
  end
end
