class Education::ProjectTechnique < ApplicationRecord
  belongs_to :project, class_name: Education::Project.name
  belongs_to :technique, class_name: Education::Technique.name
end
