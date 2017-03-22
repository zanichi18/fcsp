require "rails_helper"

RSpec.describe JobHiringType, type: :model do
  describe "JobHiringType validation" do
    context "association" do
      it{expect belong_to(:job)}
      it{expect belong_to(:hiring_type)}
    end

    context "column_specifications" do
      it{expect have_db_column(:job_id).of_type(:integer)}
      it{expect have_db_column(:hiring_type_id).of_type(:integer)}
    end
  end

  describe "validate attributes" do
    it{expect validate_presence_of(:name)}
    it{expect validate_presence_of(:description)}
  end
end
