class Organization < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.company.max_length_name}

  has_many :user_works, dependent: :destroy
  has_many :users, through: :user_works
  enum org_type: {real: 0, unreal: 1}
end
