class Education::Feedback < ApplicationRecord
  belongs_to :project, class_name: Education::Project.name
end
