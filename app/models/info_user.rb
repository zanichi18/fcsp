class InfoUser < ApplicationRecord
  belongs_to :user

  validates :introduce,
    length: {maximum: Settings.info_users.max_length_introduce}
end
