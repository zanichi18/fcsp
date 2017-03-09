class Education::Course < ApplicationRecord
  belongs_to :training, class_name: Education::Training.name

  has_many :course_members, class_name: Education::CourseMember.name,
    foreign_key: :course_id
  has_many :users, through: :course_members
end
