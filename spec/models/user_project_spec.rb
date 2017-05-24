require "rails_helper"

RSpec.describe UserProject, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_presence_of :url}
    it{is_expected.to validate_presence_of :start_date}
    it{is_expected.to validate_presence_of :end_date}
    it{is_expected.to validate_presence_of :description}

    it "validate title length" do
      is_expected.to validate_length_of(:title)
        .is_at_most Settings.user_project.max_title_length
    end
    it "is valid with a valid name" do
      expect(FactoryGirl.build(:user_project,
        title: "a" * Settings.user_project.max_title_length)).to be_valid
    end
    it "is invalid without name" do
      expect(FactoryGirl.build(:user_project, title: nil)).not_to be_valid
    end
    it "is invalid with a long name" do
      expect(FactoryGirl.build(:user_project,
        title: "a" * (Settings.user_project.max_title_length + 1)))
        .not_to be_valid
    end

    it "validate description length" do
      is_expected.to validate_length_of(:description)
        .is_at_most Settings.user_project.max_description_length
    end
    it "is valid with a valid description" do
      expect(FactoryGirl.build(:user_project,
        description: "a" * Settings.user_project.max_description_length))
        .to be_valid
    end
    it "is invalid without description" do
      expect(FactoryGirl.build(:user_project, description: nil)).not_to be_valid
    end
    it "is invalid with a long description" do
      expect(FactoryGirl.build(:user_project,
        description: "a" * (Settings.user_project.max_description_length + 1)))
        .not_to be_valid
    end

    it "is valid with a valid url" do
      expect(FactoryGirl.build(:user_project,
        url: "abc.com")).to be_valid
    end
    it "is invalid without url" do
      expect(FactoryGirl.build(:user_project,
        url: nil)).not_to be_valid
    end
    it "is invalid with a invalid url" do
      expect(FactoryGirl.build(:user_project,
        url: "abc")).not_to be_valid
    end

    it "is invalid without start date" do
      expect(FactoryGirl.build(:user_project,
        start_date: nil)).not_to be_valid
    end
    it "is invalid without end date" do
      expect(FactoryGirl.build(:user_project,
        end_date: nil)).not_to be_valid
    end
    it "is invalid with invalid date" do
      expect(FactoryGirl.build(:user_project,
        start_date: "20-05-2017", end_date: "20-03-2017")).not_to be_valid
    end
    it "is valid with valid date" do
      expect(FactoryGirl.build(:user_project,
        start_date: "20-03-2017", end_date: "20-05-2017")).to be_valid
    end
  end
end
