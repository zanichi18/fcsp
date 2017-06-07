require "rails_helper"

RSpec.describe TmsSynchronizeController, type: :controller do
  let(:user){FactoryGirl.create :user, email: "bui.khanh.huyen@framgia.com"}
  before{WebMock.allow_net_connect!}
  after{WebMock.disable_net_connect!}
  before(:each){sign_in user}

  describe "GET #index" do
    it "returns http redirect" do
      get :index
      expect(response).to have_http_status(:redirect)
    end
  end
end
