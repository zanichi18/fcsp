class Like < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user

  # scope :for_post, ->post_id{where post_id: post_id}
end
