class Education::Project < ApplicationRecord
  has_many :comments, class_name: Education::Comment.name, foreign_key: :project_id
  has_many :rates, class_name: Education::Rate.name, foreign_key: :project_id
  has_many :members, class_name: Education::ProjectMember.name, foreign_key: :project_id
  has_many :project_techniques, class_name: Education::ProjectTechnique.name,
    foreign_key: :project_id
  has_many :feedbacks, class_name: Education::Feedback.name, foreign_key: :project_id
  has_many :project_members, class_name: Education::ProjectMember.name,
    foreign_key: :project_id
  has_many :techniques, through: :project_techniques
  has_many :users, through: :project_members
end
