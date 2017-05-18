require "rails_helper"

RSpec.describe ShareJob, type: :model do
  describe "Share jobs associations" do
    context "associations" do
      it{expect belong_to :job}
      it{expect belong_to :user}
    end

    context "columns" do
      it{expect have_db_column(:user_id).of_type(:integer)}
      it{expect have_db_column(:job_id).of_type(:integer)}
    end

    context "validations" do
      let!(:user){FactoryGirl.create :user}
      let!(:job){FactoryGirl.create :job}
      let!(:share_job){FactoryGirl.create :share_job, user: user, job: job}
      it{is_expected.to validate_presence_of :job_id}
      it{expect validate_uniqueness_of(:job_id).scoped_to :user_id}
      it{is_expected.to validate_presence_of :user_id}
    end
  end
end
