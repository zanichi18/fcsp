require "rails_helper"

RSpec.describe Organization, type: :model do
  context "association" do
    it{is_expected.to have_many :user_works}
    it{is_expected.to have_many :users}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}

    it do
      is_expected.to validate_length_of(:name)
        .is_at_most Settings.company.max_length_name
    end

    it "is valid with a valid name" do
      expect(FactoryGirl.build(:organization,
        name: "a" * Settings.company.max_length_name)).to be_valid
    end

    it "is invalid without name" do
      expect(FactoryGirl.build(:organization, name: nil)).not_to be_valid
    end

    it "is invalid with a long name" do
      expect(FactoryGirl.build(:organization,
        name: "a" * (Settings.company.max_length_name + 1)))
        .not_to be_valid
    end
  end
end
