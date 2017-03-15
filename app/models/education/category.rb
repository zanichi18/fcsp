class Education::Category < ApplicationRecord
  has_many :posts, class_name: Education::Post.name,
    foreign_key: :category_id

  validates :name, presence: true,
    length: {maximum: Settings.education.category.max_length_title}
end
