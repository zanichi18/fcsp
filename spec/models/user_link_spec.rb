require "rails_helper"

RSpec.describe UserLink, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
  end

  context "column_specifications" do
    it{expect have_db_column(:link).of_type(:string)}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :link}

    it "is valid with a valid link" do
      expect(FactoryGirl.build(:user_link, link: "http://google.com"))
        .to be_valid
    end

    it "is invalid with a invalid link" do
      expect(FactoryGirl.build(:user_link, link: "abc")).not_to be_valid
    end
  end

  context "scope" do
    let!(:link1){FactoryGirl.create :user_link, created_at: Time.now}
    let!(:link2){FactoryGirl.create :user_link, created_at: Time.now + 1.hour}
    let!(:link3){FactoryGirl.create :user_link, created_at: Time.now + 2.hours}

    it "returns list newest link" do
      expect(UserLink.newest).to eq [link3, link2, link1]
    end
  end
end
