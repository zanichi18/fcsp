require "rails_helper"

RSpec.describe UserEducation, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :school}
  end

  context "column_specifications" do
    it{expect have_db_column(:school).of_type(:string)}
    it{expect have_db_column(:major).of_type(:string)}
    it{expect have_db_column(:description).of_type(:text)}
    it{expect have_db_column(:graduation).of_type(:date)}
  end
end
