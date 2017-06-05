require "rails_helper"

RSpec.describe ShareJob, type: :model do
  describe "Share jobs associations" do
    context "associations" do
      it{expect belong_to :shareable}
      it{expect belong_to :user}
    end

    context "columns" do
      it{expect have_db_column(:user_id).of_type(:integer)}
      it{expect have_db_column(:share_id).of_type(:integer)}
      it{expect have_db_column(:share_type).of_type(:string)}
    end

    context "validations" do
      let!(:user){FactoryGirl.create :user}
      let!(:job){FactoryGirl.create :job}
      let!(:share_job) do
        FactoryGirl.create :share_job, user: user, shareable: job
      end
      it{is_expected.to validate_presence_of :shareable_id}
      it{expect validate_uniqueness_of(:share_id).scoped_to :user_id}
      it{is_expected.to validate_presence_of :user_id}
    end
  end
end
