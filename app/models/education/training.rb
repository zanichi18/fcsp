class Education::Training < ApplicationRecord
  belongs_to :technique, class_name: Education::Technique.name

  has_many :courses, class_name: Education::Course.name,
    foreign_key: :training_id
end
