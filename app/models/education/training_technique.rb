class Education::TrainingTechnique < ApplicationRecord
  belongs_to :training, class_name: Education::Training.name
  belongs_to :technique, class_name: Education::Technique.name
end
