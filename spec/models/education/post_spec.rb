require "rails_helper"

RSpec.describe Education::Post, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :category}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :taggings}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_presence_of :user_id}
    it{is_expected.to validate_presence_of :category_id}
    it{is_expected.to validate_presence_of :content}
    it do
      is_expected.to validate_length_of(:title)
        .is_at_most Settings.education.post.title_max_length
    end
    it do
      is_expected.to validate_length_of(:title)
        .is_at_least Settings.education.post.title_min_length
    end
    it do
      is_expected.to validate_length_of(:content)
        .is_at_least Settings.education.post.content_min_length
    end
  end

  describe "get list newest post" do
    let!(:post1){FactoryGirl.create :education_post, created_at: Time.now}
    let!(:post2) do
      FactoryGirl.create :education_post, created_at: Time.now + 1.hour
    end
    let!(:post3) do
      FactoryGirl.create :education_post, created_at: Time.now + 2.hours
    end
    posts = Education::Post.created_desc
    it "returns ordered list" do
      expect(posts).to eq [post3, post2, post1]
    end
  end

  describe "get list related post" do
    let!(:post1){FactoryGirl.create :education_post}
    let!(:post2){FactoryGirl.create :education_another_post}
    let!(:post3) do
      FactoryGirl.create :education_post, category_id: post1.category_id
    end
    let(:related_posts){Education::Post.related_by_category post1}

    it "returns related list" do
      expect(related_posts).to eq [post3]
    end
  end

  describe "get ordered list by popular" do
    let!(:post1){FactoryGirl.create :education_post}
    let!(:post2){FactoryGirl.create :education_post}
    let!(:comment) do
      FactoryGirl.create :education_comment_post, commentable: post2
    end

    posts = Education::Post.popular
    it "returns ordered list" do
      expect(posts).to eq [post2, post1]
    end
  end
end
