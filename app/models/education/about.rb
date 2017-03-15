class Education::About < ApplicationRecord
  has_many :images, class_name: Education::Image.name, as: :imageable
end
