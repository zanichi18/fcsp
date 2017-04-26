require "rails_helper"

RSpec.describe UserPortfolio, type: :model do
  context "associations" do
    it{is_expected.to belong_to :user}
    it{is_expected.to have_many :images}
  end

  context "validations" do
    it{is_expected.to validate_presence_of :title}
    it{is_expected.to validate_presence_of :url}
    it{is_expected.to validate_presence_of :time}
    it{is_expected.to validate_presence_of :description}
    it do
      is_expected.to validate_length_of(:title)
        .is_at_least Settings.user_portfolios.title_min
    end
    it do
      is_expected.to validate_length_of(:title)
        .is_at_most Settings.user_portfolios.title_max
    end
    it do
      is_expected.to validate_length_of(:description)
        .is_at_most Settings.user_portfolios.description_max
    end
    it do
      is_expected.to validate_length_of(:description)
        .is_at_least Settings.user_portfolios.description_min
    end
  end

  context "column_specifications" do
    it{expect have_db_column(:title).of_type(:string)}
    it{expect have_db_column(:url).of_type(:string)}
    it{expect have_db_column(:time).of_type(:date)}
    it{expect have_db_column(:description).of_type(:string)}
  end
end
