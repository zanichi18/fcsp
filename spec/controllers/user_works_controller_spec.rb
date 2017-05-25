require "rails_helper"

RSpec.describe UserWorksController, type: :controller do
  let!(:user){FactoryGirl.create :user}

  before :each do
    sign_in user
  end

  context "GET #index" do
    let!(:org1){FactoryGirl.create :organization, name: "ORG1"}
    let!(:org2){FactoryGirl.create :organization, name: "ORG2"}
    it "send a request" do
      get :index, xhr: true, params: {search: "ORG"}
      expect(assigns(:orgs)).to eq [org1, org2]
    end
  end

  context "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, xhr: true
      expect(response).to have_http_status 200
    end
  end

  context "POST #create" do
    it "send a request" do
      expect do
        post :create, xhr: true, params: {user_work: {oranization: "org",
          position: "dev", description: "dev"}}
      end.to change(UserWork, :count).by 1
    end
  end

  context "PATCH #update" do
    let!(:organization){FactoryGirl.create :organization}
    let!(:user_work){organization.user_works.create}
    it "send a request" do
      patch :update, xhr: true,
        params: {id: user_work.id,
          user_work: {organization: organization.name,
          position: "dev", description: "dev"}}
      user_work.reload
      expect(user_work.position).to eq "dev"
    end
  end

  context "DELETE #destroy" do
    let!(:organization){FactoryGirl.create :organization}
    let!(:user_work){organization.user_works.create}
    it "send a request" do
      expect do
        delete :destroy, xhr: true, params: {id: user_work}
      end.to change(UserWork, :count).by -1
    end
  end
end
