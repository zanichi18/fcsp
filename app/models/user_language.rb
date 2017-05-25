class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :level, presence: true
  validates :language_id, presence: true

  delegate :name, to: :language, prefix: true, allow_nil: true

  enum level: {elementary: 0, limited: 1,
    professional: 2, full_professional: 3, native: 4}
end
