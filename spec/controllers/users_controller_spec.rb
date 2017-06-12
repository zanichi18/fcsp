require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before :each do
    sign_in user
    WebMock.allow_net_connect!
  end

  describe "GET #show" do
    context "load blocked user" do
      let!(:user){FactoryGirl.create :user, education_status: 0}
      it do
        get :show, params: {id: user}
        expect(flash[:danger]).to be_present
      end
    end

    context "load user success" do
      it "user not found" do
        get :show, params: {id: 999}
        expect(flash[:danger]).to be_present
      end

      it "user found" do
        get :show, params: {id: user}
        expect(response).to render_template :show
      end

      it "responds successfully with an HTTP 200 status code" do
        get :show, params: {id: user}, xhr: true
        expect(response).to have_http_status 200
      end

      it "responds successfully with show bookmarked jobs" do
        job = FactoryGirl.create :job
        FactoryGirl.create :bookmark, user: user, job: job
        get :show, params: {id: user, bookmarked_jobs_page: 2}, xhr: true
        expect(response).to render_template partial: "_job_accordance"
      end
    end
  end
end
