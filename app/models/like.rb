class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :for_post, -> post_id do
    where post_id: post_id
  end
end
