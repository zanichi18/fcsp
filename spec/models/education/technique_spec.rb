require "rails_helper"

RSpec.describe Education::Technique, type: :model do
  let(:technique){FactoryGirl.build(:education_technique)}

  describe "columns" do
    it{expect(technique).to have_db_column(:name).of_type(:string)}
    it{expect(technique).to have_db_column(:description).of_type(:text)}
  end

  describe "associations" do
    it{expect(technique).to have_many :project_techniques}
    it{expect(technique).to have_many :projects}
    it{expect(technique).to have_one :image}
  end
end
