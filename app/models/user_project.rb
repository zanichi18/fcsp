class UserProject < ApplicationRecord
  include ModifyLink

  before_save :modified_link

  belongs_to :user

  validates :title, presence: true,
    length: {maximum: Settings.user_project.max_title_length}
  validates :url, presence: true, url: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_date :end_date, after: :start_date
  validates :description, presence: true,
    length: {maximum: Settings.user_project.max_description_length}
end
