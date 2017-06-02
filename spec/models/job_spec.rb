require "rails_helper"

RSpec.describe Job, type: :model do
  describe "Job validation" do
    context "association" do
      it{expect belong_to(:company)}
      it{expect have_many(:images)}
      it{expect have_many(:hiring_types)}
      it{expect have_many(:job_hiring_types)}
    end

    context "column_specifications" do
      it{expect have_db_column(:title).of_type(:string)}
      it{expect have_db_column(:describe).of_type(:string)}
      it{expect have_db_column(:type_of_candidates).of_type(:integer)}
      it{expect have_db_column(:candidates_count).of_type(:integer)}
      it{expect have_db_column(:who_can_apply).of_type(:integer)}
      it{expect have_db_column(:company_id).of_type(:integer)}
      it{expect have_db_column(:status).of_type(:integer)}
      it{expect have_db_column(:profile_requests).of_type(:string)}
    end
  end

  describe "validate attributes" do
    it{expect validate_presence_of(:title)}
    it do
      expect validate_length_of(:title)
        .is_at_most Settings.max_length_title
    end
    it{expect validate_presence_of(:describe)}
    it{expect validate_presence_of(:type_of_candidates)}
    it{expect validate_presence_of(:who_can_apply)}
  end
end
