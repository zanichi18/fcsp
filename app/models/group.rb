class Group < ApplicationRecord
  belongs_to :company
  has_many :permissions
end
