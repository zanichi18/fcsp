class InfoUser < ApplicationRecord
  belongs_to :user

  INFO_ATTRIBUTES = [:introduction, :ambition, :portfolio, :award, :work,
    :education, :link, :project, :certificate, :language, :skill]
  INFO_STATUS = {only_me: 0, public: 1}

  serialize :info_statuses, Hash

  validates :introduce,
    length: {maximum: Settings.info_users.max_length_introduce}
  validates :ambition,
    length: {maximum: Settings.info_users.max_length_ambition}
  validates :quote,
    length: {maximum: Settings.info_users.max_length_quote}
  validates :address, presence: true
end
