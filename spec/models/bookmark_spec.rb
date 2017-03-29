require "rails_helper"

RSpec.describe Bookmark, type: :model do
  describe "Bookmark validation" do
    context "association" do
      it{expect belong_to(:user)}
      it{expect belong_to(:job)}
    end

    context "column_specifications" do
      it{expect have_db_column(:user_id).of_type(:integer)}
      it{expect have_db_column(:job_id).of_type(:integer)}
    end
  end
end
