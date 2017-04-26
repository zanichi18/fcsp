require "rails_helper"
RSpec.describe Award, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
  end

  describe "validations" do
    it{expect validate_presence_of(:name)}
    it{expect validate_presence_of(:time)}
  end
end
