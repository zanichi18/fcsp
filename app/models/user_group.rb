class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :position
  has_one :company, through: :group

  class << self
    def default
      find_by is_default_group: true
    end
  end
end
