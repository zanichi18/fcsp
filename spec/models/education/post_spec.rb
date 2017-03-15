require "rails_helper"

RSpec.describe Education::Post, type: :model do
  context "associations" do
    it{is_expected.to have_many :images}
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :category}
  end

  context "validates" do
    it{is_expected.to validate_presence_of :content}
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_length_of(:title).is_at_most(200)}
    it "is valid with a valid title" do
      expect(FactoryGirl.build(:education_post, title: "a" * 20)).to be_valid
    end
    it "is invalid with a long title" do
      expect(FactoryGirl.build(:education_post, title: "a" * 201))
        .not_to be_valid
    end
  end

  describe ".created_desc" do
    let!(:post1){FactoryGirl.create :education_post, created_at: Time.now}
    let!(:post2) do
      FactoryGirl.create :education_post, created_at: Time.now + 1.hour
    end
    let!(:post3) do
      FactoryGirl.create :education_post, created_at: Time.now + 2.hours
    end
    it{expect(Education::Post.created_desc).to eq [post3, post2, post1]}
  end
end
