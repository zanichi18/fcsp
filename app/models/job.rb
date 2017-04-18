class Job < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :images, as: :imageable, dependent: :destroy
  has_many :job_hiring_types, dependent: :destroy
  has_many :hiring_types, through: :job_hiring_types
  has_many :candidates, dependent: :destroy, counter_cache: true
  has_many :bookmarks, dependent: :destroy
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :team_introductions, as: :team_target

  enum status: [:draft, :active, :close]
  enum who_can_apply: [:everyone, :friends_of_members,
    :friends_of_friends_of_member]
  enum type_of_candidates: [:engineer, :creative, :director, :business_admin,
    :sales, :marketing, :medical, :others]

  accepts_nested_attributes_for :job_hiring_types,
    reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :images

  delegate :name, to: :company, prefix: true
  delegate :name, to: :hiring_types, prefix: true

  ATTRIBUTES = [:title, :describe, :type_of_candidates, :who_can_apply, :status,
    :company_id, hiring_type_ids: [], images_attributes: [:id,
    :imageable_id, :imageable_type, :picture, :caption]]

  TYPEOFCANDIDATES = Job.type_of_candidates
    .map{|temp,| [I18n.t(".type_of_candidates.#{temp}"), temp]}
    .sort_by{|temp| I18n.t(".type_of_candidates.#{temp}")}

  validates :title, presence: true, length: {maximum: Settings.max_length_title}
  validates :describe, presence: true
  validates :type_of_candidates, presence: true
  validates :who_can_apply, presence: true
  validates :profile_requests, presence: true

  scope :newest, ->{order created_at: :desc}
  scope :all_job, ->{}
  scope :of_ids, ->ids do
    where id: ids if ids.present?
  end
end
