require "rails_helper"

RSpec.describe JobSkill, type: :model do
  describe "Job Skill validation" do
    context "association" do
      it{expect belong_to(:job)}
      it{expect belong_to(:skill)}
    end

    context "column_specifications" do
      it{expect have_db_column(:skill_id).of_type(:integer)}
      it{expect have_db_column(:job_id).of_type(:integer)}
    end
  end
end
