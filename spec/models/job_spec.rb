require "rails_helper"

RSpec.describe Job, type: :model do
  describe "Job validation" do
    context "association" do
      it{expect belong_to(:company)}
      it{expect have_many(:images)}
    end

    context "column_specifications" do
      it{expect have_db_column(:title).of_type(:string)}
      it{expect have_db_column(:describe).of_type(:string)}
      it{expect have_db_column(:type_of_candidates).of_type(:integer)}
      it{expect have_db_column(:who_can_apply).of_type(:integer)}
      it{expect have_db_column(:company_id).of_type(:integer)}
    end
  end

  describe "validate attributes" do
    it{expect validate_presence_of(:title)}
    it do
      expect validate_length_of(:title)
        .is_at_most Settings.max_length_title
    end
    it{expect validate_presence_of(:describe)}
  end
end
