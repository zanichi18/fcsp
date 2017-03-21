require "rails_helper"
require "companies_controller"

RSpec.describe CompaniesController, type: :controller do
  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      company = FactoryGirl.create :company
      get :show, params: {id: company.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
