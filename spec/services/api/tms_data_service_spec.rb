require "rails_helper"

describe Api::TmsDataService do
  let(:user_email){"chu.anh.tuan@framgia.com"}
  let(:password){"12345678"}
  let(:current_user) do
    FactoryGirl.create :user,
      email: "bui.khanh.huyen@framgia.com"
  end
  let(:authenticate_service) do
    Api::AuthenticateService.new(user_email, password).tms_authenticate
  end
  let(:auth_token){authenticate_service["authen_token"]}

  before{WebMock.allow_net_connect!}
  after{WebMock.disable_net_connect!}

  describe "synchronize data tms" do
    it "get data and update success" do
      tms_service = Api::TmsDataService.new current_user, auth_token
      expect(tms_service.synchronize_tms_data).to be true
    end

    it "get data success but update fail" do
      allow(UserEducation).to receive(:find_or_create_by).and_return false
      tms_service = Api::TmsDataService.new current_user, auth_token
      expect(tms_service.synchronize_tms_data).to be false
    end

    it "failure get data from tms api" do
      tms_service = Api::TmsDataService.new current_user, "WRONG_TOKEN"
      expect(tms_service.synchronize_tms_data).to be false
    end
  end
end
