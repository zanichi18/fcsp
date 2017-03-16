class Education::Training < ApplicationRecord
  has_many :courses, class_name: Education::Course.name,
    foreign_key: :training_id
  has_many :images, as: :imageable
  has_many :training_techniques, class_name: Education::TrainingTechnique.name,
    foreign_key: :training_id
  has_many :techniques, through: :training_techniques

  scope :newest, ->{order created_at: :desc}
end
