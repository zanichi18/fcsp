require "rails_helper"

RSpec.describe Industry, type: :model do
  describe "Industry validation" do
    context "association" do
      it{expect have_many(:companies)}
      it{expect have_many(:company_industries)}
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
    end
  end

  describe "validate attributes" do
    it{expect validate_presence_of(:name)}
    it do
      expect validate_length_of(:name)
        .is_at_most Settings.industries.max_length_name
    end
  end
end
