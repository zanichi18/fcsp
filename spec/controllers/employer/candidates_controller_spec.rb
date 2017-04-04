require "rails_helper"

RSpec.describe Employer::CandidatesController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let(:job){FactoryGirl.create :job}
  let!(:candidate){FactoryGirl.create :candidate, user_id: 1, job_id: job.id}
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {company_id: company.id}
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "get candidates of a job successfully" do
      get :index, params: {company_id: company.id, job_id: job.id}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "get all candidates of company successfully when job_id is empty" do
      get :index, params: {company_id: company.id, job_id: ""}, xhr: true
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "render template successfully when using xhr request" do
      get :index, params: {company_id: company.id, job_id: job.id}, xhr: true
      expect(response).to render_template("employer/candidates/_candidate")
    end
  end
end
