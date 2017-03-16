class Education::Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  delegate :name, to: :user, prefix: true

  validates :content, presence: true,
    length: {maximum: Settings.education.comment.max_content_length}

  scope :newest, ->{order created_at: :desc}
end
