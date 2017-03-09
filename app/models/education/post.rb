class Education::Post < ApplicationRecord
  belongs_to :category, class_name: Education::Category.name
  belongs_to :user
end
