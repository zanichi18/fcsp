require "rails_helper"

RSpec.describe Employer::CandidatesController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let(:job){FactoryGirl.create :job}
  let(:group){FactoryGirl.create :group, name: "HR", company_id: company.id}
  let(:group_user){FactoryGirl.create :group_user, user_id: user.id,
    group_id: group.id}
  let(:permission){FactoryGirl.create :permission, entry: "Company",
    optional: {create: true, read: true, update: true, destroy: true},
    group_id: group.id}
  let!(:candidate){FactoryGirl.create :candidate, user_id: 1, job_id: job.id}

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {company_id: company.id}
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "get candidates of a job successfully" do
      get :index, params: {company_id: company.id, select: job.id}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "get all candidates of company successfully when params select is empty" do
      get :index, params: {company_id: company.id, select: ""}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "render template successfully when using xhr request" do
      get :index, params: {company_id: company.id, select: job.id}, xhr: true
      expect(response).to render_template("employer/candidates/_candidate")
      expect(response).to render_template("employer/candidates/_paginate")
    end

    it "request xhr successfully, get follow type of candidates" do
      get :index, params: {company_id: company.id, select: job.id,
        type: "process", sort: "ASC", array_id: [1, 2, 3], page: 1}, xhr: true
      expect(response).to render_template("employer/candidates/_candidate")
      expect(response).to render_template("employer/candidates/_paginate")
    end
  end

  describe "PUT #update" do
    it "request xhr, update candidates" do
      patch :update, params: {company_id: company.id, type: 1, id: 10}, xhr: true
      expect(response).to render_template("employer/candidates/_change_process")
    end
  end
end
