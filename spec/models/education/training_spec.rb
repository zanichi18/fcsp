require "rails_helper"

RSpec.describe Education::Training, type: :model do
  context "associations" do
    it{is_expected.to have_many :courses}
    it{is_expected.to have_many :images}
    it{is_expected.to have_many :training_techniques}
    it{is_expected.to have_many :techniques}
  end

  describe "get list training" do
    let!(:training1){FactoryGirl.create :training, created_at: Time.now}
    let!(:training2) do
      FactoryGirl.create :training, created_at: Time.now + 1.hour
    end
    let!(:training3) do
      FactoryGirl.create :training, created_at: Time.now + 2.hours
    end
    trainings = Education::Training.newest
    it "returns list training ordered" do
      expect(trainings).to eq [training3, training2, training1]
    end
  end
end
