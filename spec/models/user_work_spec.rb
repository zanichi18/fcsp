require "rails_helper"

RSpec.describe UserWork, type: :model do
  context "association" do
    it{is_expected.to belong_to :organization}
    it{is_expected.to belong_to :user}
  end
end
