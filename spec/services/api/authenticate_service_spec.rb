require "rails_helper"

describe Api::AuthenticateService do
  let(:uri){"http://ishipper.framgia.vn/api/users/sign_in"}
  let(:email){"chu.anh.tuan@framgia.com"}
  let(:password){"12345678"}
  let(:params){{"user[email]": email, "user[password]": password}}
  let(:response_success){{messages: "Signed in successfully."}}

  before{WebMock.allow_net_connect!}
  after{WebMock.disable_net_connect!}

  describe "#tms_authenticate" do
    it "login success" do
      data_response = Api::AuthenticateService.new(email, password)
        .tms_authenticate
      expect(data_response["messages"]).to eq response_success[:messages]
    end

    it "login fail" do
      email = "em_con_nho_hay_em_da_quen@gmail.com"
      data_response = Api::AuthenticateService.new(email, password)
        .tms_authenticate
      expect(data_response).to be false
    end
  end
end
