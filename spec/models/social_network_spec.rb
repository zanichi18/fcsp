require "rails_helper"

RSpec.describe SocialNetwork, type: :model do
  context "association" do
    it{is_expected.to belong_to :owner}
  end

  context "validations" do
    it "is valid with a valid url" do
      expect(FactoryGirl.build(:user_link, link: "http://google.com"))
        .to be_valid
    end

    it "is invalid with a invalid link" do
      expect(FactoryGirl.build(:user_link, link: "abc")).not_to be_valid
    end
  end
end
