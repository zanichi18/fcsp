class Education::Course < ApplicationRecord
  translates :detail

  belongs_to :training, class_name: Education::Training.name

  has_many :course_members, class_name: Education::CourseMember.name,
    foreign_key: :course_id, dependent: :destroy
  has_many :users, through: :course_members
  has_many :images, class_name: Education::Image.name, as: :imageable,
    dependent: :destroy

  validates :name, presence: true
  validates :detail, presence: true

  scope :newest, ->{order created_at: :desc}

  accepts_nested_attributes_for :images, allow_destroy: true
end
