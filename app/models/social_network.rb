class SocialNetwork < ApplicationRecord
  include ModifyLink
  before_save :modified_link

  belongs_to :owner, polymorphic: true

  validates :url, url: true, allow_blank: true

  enum social_network_type: [:facebook, :google, :twitter, :linkedin, :skype,
    :youtube, :instagram]
end
