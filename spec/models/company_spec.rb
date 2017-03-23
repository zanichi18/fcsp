require "rails_helper"

RSpec.describe Company, type: :model do
  describe "Company associations" do
    context "columns" do
      it{should have_db_column(:name).of_type(:string)}
      it{should have_db_column(:website).of_type(:string)}
      it{should have_db_column(:introduction).of_type(:text)}
      it{should have_db_column(:founder).of_type(:string)}
      it{should have_db_column(:country).of_type(:string)}
      it{should have_db_column(:company_size).of_type(:integer)}
      it{should have_db_column(:founder_on).of_type(:date)}
    end

    context "associations" do
      it{expect have_many :jobs}
      it{expect have_many :benefits}
      it{expect have_many :addresses}
      it{expect have_many :employees}
      it{expect have_many :teams}
      it{expect have_many :articles}
      it{expect have_many :images}
      it{expect have_many :team_introductions}
      it{expect have_many :indutries}
      it{expect have_many :company_industries}
    end
  end

  describe "validations" do
    it{expect validate_presence_of(:name)}
    it do
      expect validate_length_of(:name)
        .is_at_most Settings.company.max_length_name
    end
    it{expect validate_presence_of(:website)}
    it{expect validate_numericality_of(:company_size).is_greater_than(0)}
  end
end
