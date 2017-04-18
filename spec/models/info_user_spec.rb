require "rails_helper"

RSpec.describe InfoUser, type: :model do
  describe "InfoUser validation" do
    context "column_specifications" do
      it{expect have_db_column(:introduce).of_type(:text)}
      it{expect have_db_column(:quote).of_type(:string)}
      it{expect have_db_column(:ambition).of_type(:string)}
      it{expect have_db_column(:relationship_status).of_type(:integer)}
    end

    context "associations" do
      it{is_expected.to belong_to :user}
    end
  end
end
