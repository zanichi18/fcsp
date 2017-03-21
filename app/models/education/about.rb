class Education::About < ApplicationRecord
  translates :title, :content

  has_many :images, class_name: Education::Image.name, as: :imageable
end
