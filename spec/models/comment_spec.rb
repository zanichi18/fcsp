require "rails_helper"

RSpec.describe Comment, type: :model do
  context "associations" do
    it{is_expected.to belong_to :post}
    it{is_expected.to belong_to :user}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :content}
    it do
      is_expected.to validate_length_of(:content)
        .is_at_most Settings.comment.max_content_length
    end
  end

  describe "get list comment" do
    let!(:user){FactoryGirl.create :user}
    let!(:post){FactoryGirl.create :user_post}
    let!(:comment1){FactoryGirl.create :comment_user_post, created_at: Time.now}
    let!(:comment2) do
      FactoryGirl.create :comment_user_post, created_at: Time.now + 1.hour
    end
    comments = Comment.newest
    it "returns list order comment" do
      expect(comments).to eq [comment2, comment1]
    end
  end
end
