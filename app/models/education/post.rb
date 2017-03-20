class Education::Post < ApplicationRecord
  translates :title, :content

  belongs_to :category, class_name: Education::Category.name
  belongs_to :user
  has_many :images, class_name: Education::Image.name, as: :imageable

  validates :title, presence: true,
    length: {maximum: Settings.education.posts.max_length_title}
  validates :content, presence: true

  delegate :email, to: :user, prefix: true
  delegate :name, to: :category, prefix: true

  scope :created_desc, ->{order created_at: :desc}
end
