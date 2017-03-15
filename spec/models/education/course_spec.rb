require "rails_helper"

RSpec.describe Education::Course, type: :model do
  context "associations" do
    it{is_expected.to have_many :course_members}
    it{is_expected.to have_many :users}
    it{is_expected.to have_many :images}
    it{is_expected.to belong_to :training}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_presence_of :detail}
  end

  describe "show list course" do
    let!(:training){FactoryGirl.create :training}
    let!(:course1){FactoryGirl.create :course, created_at: Time.now}
    let!(:course2){FactoryGirl.create :course, created_at: Time.now + 1.hour}
    course = Education::Course.newest
    it "returns list order course" do
      expect(course).to eq [course2, course1]
    end
  end
end
