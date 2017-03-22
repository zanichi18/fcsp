class Education::Group < ApplicationRecord
  translates :description

  has_many :permissions, class_name: Education::Permission.name,
    foreign_key: :group_id
  has_many :user_groups, class_name: Education::UserGroup.name,
    foreign_key: :group_id
  has_many :users, through: :user_groups
end
