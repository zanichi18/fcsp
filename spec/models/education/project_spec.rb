require "rails_helper"

RSpec.describe Education::Project, type: :model do
  context "associations" do
    it{is_expected.to have_many :rates}
    it{is_expected.to have_many :members}
    it{is_expected.to have_many :project_techniques}
    it{is_expected.to have_many :techniques}
    it{is_expected.to have_many :users}
    it{is_expected.to have_many :images}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_presence_of :description}
    it{is_expected.to validate_presence_of :core_features}
    it{is_expected.to validate_presence_of :release_note}
    it{is_expected.to validate_presence_of :plat_form}
    it{is_expected.to validate_presence_of :pm_url}
    it{is_expected.to validate_presence_of :server_info}
  end

  describe "get list project" do
    let!(:project1){FactoryGirl.create :project, created_at: Time.now}
    let!(:project2){FactoryGirl.create :project, created_at: Time.now + 1.hour}
    let!(:project3){FactoryGirl.create :project, created_at: Time.now + 2.hours}
    projects = Education::Project.newest
    it "returns list order project" do
      expect(projects).to eq [project3, project2, project1]
    end
  end
end
