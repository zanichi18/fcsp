class Education::Category < ApplicationRecord
  has_many :posts, class_name: Education::Post.name,
    foreign_key: :category_id, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.education.category.max_length_title}

  scope :newest, ->{order created_at: :desc}
end
