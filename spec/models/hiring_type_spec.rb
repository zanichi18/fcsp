require "rails_helper"

RSpec.describe HiringType, type: :model do
  describe "HiringType validation" do
    context "association" do
      it{expect have_many(:jobs)}
      it{expect have_many(:job_hiring_types)}
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:description).of_type(:string)}
      it{expect have_db_column(:status).of_type(:integer)}
    end
  end

  describe "validate attributes" do
    it{expect validate_presence_of(:name)}
    it do
      expect validate_length_of(:name)
        .is_at_most Settings.hiring_type.max_length_name
    end
    it{expect validate_presence_of(:description)}
  end
end
