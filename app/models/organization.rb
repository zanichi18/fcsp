class Organization < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.company.max_length_name}

  has_many :user_works, dependent: :destroy
  has_many :users, through: :user_works
  enum org_type: {real: 0, unreal: 1}

  scope :of_ids, ->ids{where id: ids}
  scope :except_org, ->org{where.not id: org.id}
end
