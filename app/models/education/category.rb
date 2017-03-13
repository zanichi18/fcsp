class Education::Category < ApplicationRecord
  has_many :posts, class_name: Education::Post.name,
    foreign_key: :category_id
end
