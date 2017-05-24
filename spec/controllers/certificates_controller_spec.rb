require "rails_helper"

RSpec.describe CertificatesController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:certificate){FactoryGirl.create :certificate}
  let(:params_true) do
    FactoryGirl.attributes_for :certificate, name: "Certification 1",
      qualified_time: "22-02-2017", qualified_organization: "Organization 1"
  end
  let(:params_fail){FactoryGirl.attributes_for :certificate, name: nil}
  before do
    sign_in user
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, xhr: true
      expect(response).to have_http_status 200
    end
  end

  describe "POST #create" do
    it "create certificate successfully" do
      expect do
        post :create, xhr: true,
          params: {certificate: FactoryGirl.attributes_for(:certificate)}
      end.to change(Certificate, :count).by 1
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "update certificate success" do
        patch :update, params: {id: certificate,
          certificate: params_true}, format: :js
      end
    end

    context "with invalid attributes" do
      it "update fail" do
        patch :update, params: {id: certificate,
          certificate: params_fail}, format: :js
      end
    end

    context "cannot load certificate" do
      before do
        allow(User).to receive(:find_by).and_return(nil)
        get :update, params: {id: 100, status: 2}
      end

      it "redirect to user_path" do
        expect(response).to redirect_to user_path user
      end

      it "get a flash danger" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    it "responds successfully" do
      delete :destroy, params: {id: certificate.id}, xhr: true
      expect{to change(certificate, :count).by(-1)}
    end
  end
end
