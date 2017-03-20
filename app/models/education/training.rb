class Education::Training < ApplicationRecord
  translates :description

  has_many :courses, class_name: Education::Course.name,
    foreign_key: :training_id
  has_many :images, as: :imageable
  has_many :training_techniques, class_name: Education::TrainingTechnique.name,
    foreign_key: :training_id, dependent: :destroy
  has_many :techniques, through: :training_techniques

  validates :name, presence: true
  validates :description, presence: true

  scope :newest, ->{order created_at: :desc}
end
