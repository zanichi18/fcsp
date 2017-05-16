require "rails_helper"

RSpec.describe Team, type: :model do
  describe "Team validation" do
    context "association" do
      it{expect belong_to(:company)}
      it{expect have_many(:images)}
      it{expect have_many(:team_introductions)}
    end

    context "column_specifications" do
      it{expect have_db_column(:company_id).of_type(:integer)}
      it{expect have_db_column(:name).of_type(:string)}
    end
  end
end
