require "rails_helper"

RSpec.describe Candidate, type: :model do
  describe "Candidate associations" do
    context "columns" do
      it{should have_db_column(:user_id).of_type(:integer)}
      it{should have_db_column(:job_id).of_type(:integer)}
    end

    context "validates" do
      it{is_expected.to validate_presence_of :job_id}
      it{is_expected.to validate_presence_of :user_id}
    end

    context "associations" do
      it{expect belong_to :job}
      it{expect belong_to :user}
    end
  end
end
