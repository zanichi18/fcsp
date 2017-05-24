require "rails_helper"

RSpec.describe Post, type: :model do
  context "association" do
    it{is_expected.to belong_to :postable}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :content}
    it{is_expected.to validate_presence_of :title}

    it "is valid with a valid title" do
      expect(FactoryGirl.build(:user_post,
        title: "a" * Settings.post.title_max)).to be_valid
    end

    it "is invalid with a long title" do
      expect(FactoryGirl.build(:user_post,
        title: "a" * (Settings.post.title_max + 1))).not_to be_valid
    end
  end

  context "scope" do
    let!(:post1){FactoryGirl.create :user_post, created_at: Time.now}
    let!(:post2){FactoryGirl.create :user_post, created_at: Time.now + 1.hour}
    let!(:post3){FactoryGirl.create :user_post, created_at: Time.now + 2.hours}

    it "returns list newest post" do
      expect(Post.newest).to eq [post3, post2, post1]
    end
  end
end
