class Permission < ApplicationRecord
  belongs_to :group

  serialize :optional, Hash
end
