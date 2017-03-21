require "rails_helper"

RSpec.describe CompanyIndustry, type: :model do
  describe "CompanyIndustry validation" do
    context "association" do
      it{expect belong_to(:company)}
      it{expect belong_to(:industry)}
    end

    context "column_specifications" do
      it{expect have_db_column(:company_id).of_type(:integer)}
      it{expect have_db_column(:industry_id).of_type(:integer)}
    end
  end
end
