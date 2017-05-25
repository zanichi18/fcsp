class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user

  delegate :name, to: :user, prefix: true
  delegate :avatar, to: :user, prefix: true

  validates :content, presence: true,
    length: {maximum: Settings.comment.max_content_length}

  scope :newest, ->{order created_at: :desc}
end
