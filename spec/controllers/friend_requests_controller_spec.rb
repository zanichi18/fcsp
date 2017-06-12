require "rails_helper"

RSpec.describe FriendRequestsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before :each do
    sign_in user
  end

  describe "GET #index" do
    before :each do
      get :index
      expect(response).to have_http_status :success
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status 200
    end
  end
end
