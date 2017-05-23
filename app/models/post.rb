class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true

  validates :title, presence: true, length: {maximum: Settings.post.title_max}
  validates :content, presence: true

  delegate :name, to: :postable, prefix: true

  scope :newest, ->{order created_at: :desc}
end
