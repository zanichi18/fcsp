class Education::Image < ApplicationRecord
  belongs_to :imageable, class_name: Education::Image.name, polymorphic: true
end
