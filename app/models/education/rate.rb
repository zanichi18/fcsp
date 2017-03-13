class Education::Rate < ApplicationRecord
  belongs_to :user
  belongs_to :project, class_name: Education::Project.name
end
