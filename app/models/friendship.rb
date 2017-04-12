class Friendship < ApplicationRecord
  enum status: {pending: 0, requested: 1, accepted: 2, blocked: 3}
end
