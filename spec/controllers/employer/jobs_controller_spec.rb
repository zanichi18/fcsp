require "rails_helper"

RSpec.describe Employer::JobsController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let!(:job){FactoryGirl.create :job, company_id: company.id}

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #index" do
    it "populates an array of jobs" do
      get :index, params: {company_id: company}
      expect(assigns(:jobs)).to include job
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status 200
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new, params: {company_id: company.id}
      expect(response).to render_template :new
    end
  end

  describe "POST #create job" do
    it "create community job successfully" do
      job_params = FactoryGirl.attributes_for :job
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 1
    end

    it "create job only preview" do
      job_params = FactoryGirl.attributes_for :job
      expect do
        post :create, params: {company_id: company, preview: "Preview",
          job: job_params}
      end.to change(Job, :count).by 1
    end

    it "create fail with title nil" do
      job_params = FactoryGirl.attributes_for :job, title: nil
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
    end

    it "create fail by reaching length limitation" do
      title = "a" * 151
      job_params = FactoryGirl.attributes_for :job, title: title
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
    end

    it "create fail with describe nil" do
      job_params = FactoryGirl.attributes_for :job, describe: nil
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
    end
  end

  describe "PUT #update" do
    it "update successfully" do
      job_params = FactoryGirl.attributes_for :job, title: "something"
      put :update, params: {company_id: company, id: job, job: job_params}
      job.reload
      expect(job.title).to eq "something"
    end
  end

  describe "DELETE #destroy" do
    context "delete successfully" do
      before{delete :destroy, params: {company_id: company, id: job}}
      it{expect{response.to change(Job, :count).by -1}}
    end

    it "delete fail" do
      allow_any_instance_of(Job).to receive(:destroy).and_return(false)
      expect do
        delete :destroy, params: {company_id: company, id: job}
      end.not_to change(Job, :count)
    end
  end
end
