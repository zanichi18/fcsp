class Education::Post < ApplicationRecord
  include PublicActivity::Model
  tracked owner: proc{|controller| controller.current_user if controller}

  translates :title
  acts_as_taggable_on :tags

  belongs_to :category, class_name: Education::Category.name
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true,
    length: {maximum: Settings.education.post.title_max_length,
      minimum: Settings.education.post.title_min_length}
  validates :content, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :content, presence: true,
    length: {minimum: Settings.education.post.content_min_length}

  delegate :name, to: :user, prefix: true
  delegate :avatar, to: :user, prefix: true
  delegate :name, to: :category, prefix: true

  scope :created_desc, ->{order created_at: :desc}
  scope :related_by_category, ->post do
    where "category_id = #{post.category_id} AND id != #{post.id}"
  end
  scope :popular, ->{order comments_count: :desc}
end
