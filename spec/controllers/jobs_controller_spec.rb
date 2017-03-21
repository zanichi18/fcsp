require "rails_helper"

RSpec.describe JobsController, type: :controller do
  describe "GET #index" do
    before :each do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show/:id" do
    it "job not found" do
      get :show, params: {id: 100}
      expect(response).to have_http_status(404)
    end
  end
end
