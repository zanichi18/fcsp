class Education::Technique < ApplicationRecord
  has_many :project_techniques, class_name: Education::ProjectTechnique.name,
    foreign_key: :technique_id
  has_many :trainings, class_name: Education::Training.name,
    foreign_key: :technique_id
  has_many :projects, through: :project_techniques

  has_one :image, as: :imageable, class_name: Education::Image,
    dependent: :destroy
end
