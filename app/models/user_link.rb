class UserLink < ApplicationRecord
  before_save :modified_link

  belongs_to :user

  validates :link, presence: true, url: true

  scope :newest, ->{order created_at: :desc}

  private

  def modified_link
    unless self.link.include?("http://") || self.link.include?("https://")
      self.link = "http://" + self.link
    end
  end
end
