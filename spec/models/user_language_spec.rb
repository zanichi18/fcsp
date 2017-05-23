require "rails_helper"

RSpec.describe UserLanguage, type: :model do
  context "association" do
    it{is_expected.to belong_to :language}
    it{is_expected.to belong_to :user}
  end

  context "column_specifications" do
    it{expect have_db_column(:language_id).of_type(:integer)}
    it{expect have_db_column(:user_id).of_type(:integer)}
    it{expect have_db_column(:level).of_type(:integer)}
  end

  context "validation" do
    it{is_expected.to validate_presence_of :level}
  end
end
