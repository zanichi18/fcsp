class Education::CourseMember < ApplicationRecord
  belongs_to :user
  belongs_to :course, class_name: Education::Course.name
end
