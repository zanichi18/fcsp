class Education::Training < ApplicationRecord
  translates :description

  has_many :courses, class_name: Education::Course.name,
    foreign_key: :training_id, dependent: :destroy
  has_many :images, as: :imageable
  has_many :training_techniques, class_name: Education::TrainingTechnique.name,
    foreign_key: :training_id, dependent: :destroy
  has_many :techniques, through: :training_techniques

  validates :name, presence: true
  validates :description, presence: true

  scope :newest, ->{order created_at: :desc}

  scope :filter_by_technique, ->technique_name do
    left_outer_joins(:techniques)
      .where("education_techniques.name LIKE ?", technique_name).distinct
  end
end
