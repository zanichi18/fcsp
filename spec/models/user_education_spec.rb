require "rails_helper"

RSpec.describe UserEducation, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :school}
    it{is_expected.to validate_presence_of :major}
    it{is_expected.to validate_presence_of :description}
    it{is_expected.to validate_presence_of :graduation}
    it do
      is_expected.to validate_length_of(:school)
        .is_at_least Settings.user_educations.school_min
    end
    it do
      is_expected.to validate_length_of(:school)
        .is_at_most Settings.user_educations.school_max
    end
    it do
      is_expected.to validate_length_of(:major)
        .is_at_most Settings.user_educations.major_max
    end
    it do
      is_expected.to validate_length_of(:major)
        .is_at_least Settings.user_educations.major_min
    end
    it do
      is_expected.to validate_length_of(:description)
        .is_at_least Settings.user_educations.description_min
    end
    it do
      is_expected.to validate_length_of(:description)
        .is_at_most Settings.user_educations.description_max
    end
  end

  context "column_specifications" do
    it{expect have_db_column(:school).of_type(:string)}
    it{expect have_db_column(:major).of_type(:string)}
    it{expect have_db_column(:description).of_type(:text)}
    it{expect have_db_column(:graduation).of_type(:date)}
  end
end
