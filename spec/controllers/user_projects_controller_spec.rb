require "rails_helper"

RSpec.describe UserProjectsController, type: :controller do
  let!(:user){FactoryGirl.create :user}

  before :each do
    sign_in user
  end

  context "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, xhr: true
      expect(response).to have_http_status 200
    end
  end

  context "POST #create" do
    it "save valid user project to database" do
      expect do
        post :create, xhr: true,
          params: {user_project: FactoryGirl.attributes_for(:user_project)}
      end.to change(UserProject, :count).by 1
    end
  end

  context "PATCH #update" do
    let!(:user_project){FactoryGirl.create(:user_project)}
    it "send a request" do
      patch :update, xhr: true,
        params: {id: user_project.id, user_project:
          FactoryGirl.attributes_for(:user_project, title: "Update Project")}
      user_project.reload
      expect(user_project.title).to eq "Update Project"
    end
  end

  context "DELETE #destroy" do
    let!(:user_project){FactoryGirl.create(:user_project)}
    it "send a request" do
      expect do
        delete :destroy, xhr: true, params: {id: user_project}
      end.to change(UserProject, :count).by -1
    end
  end
end
