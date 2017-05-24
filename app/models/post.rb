class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: {maximum: Settings.post.title_max}
  validates :content, presence: true

  delegate :name, to: :postable, prefix: true

  scope :newest, ->{order created_at: :desc}
end
