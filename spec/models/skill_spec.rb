require "rails_helper"

RSpec.describe Skill, type: :model do
  describe "Skill validation" do
    context "association" do
      it{expect have_many(:users).through(:skill_users)}
      it{expect have_many(:jobs).through(:job_skills)}
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:description).of_type(:text)}
      it{expect have_db_column(:level).of_type(:integer)}
    end
  end

  describe "validate attributes" do
    it{expect validate_presence_of(:name)}
    it do
      expect validate_length_of(:name)
        .is_at_most Settings.max_length_title
    end

    it do
      expect validate_length_of(:description)
        .is_at_most Settings.max_length_description
    end
  end
end
