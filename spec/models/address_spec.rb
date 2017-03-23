require "rails_helper"

RSpec.describe Address, type: :model do
  describe "Address validation" do
    context "association" do
      it{expect belong_to(:company)}
    end

    context "column_specifications" do
      it{expect have_db_column(:address).of_type(:string)}
      it{expect have_db_column(:longtitude).of_type(:float)}
      it{expect have_db_column(:latitude).of_type(:float)}
      it{expect have_db_column(:head_office).of_type(:boolean)}
    end
  end
end
