require "rails_helper"

RSpec.describe Employer::JobsController, type: :controller do
  describe "POST #create job" do
    let(:admin){FactoryGirl.create :user, role: 1}
    let(:company){FactoryGirl.create :company}

    before :each do
      allow(controller).to receive(:current_user).and_return(admin)
      sign_in admin
      request.env["HTTP_REFERER"] = "sample_path"
    end

    it "create successfully" do
      job_params = FactoryGirl.attributes_for :job
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 1
      expect(flash[:success]).to be_present
    end

    it "create fail with title nil" do
      job_params = FactoryGirl.attributes_for :job, title: nil
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
      expect(flash[:danger]).to be_present
    end

    it "create fail by reaching length limitation" do
      title = FFaker::Lorem.paragraph
      job_params = FactoryGirl.attributes_for :job, title: title
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
      expect(flash[:danger]).to be_present
    end

    it "create fail with describe nil" do
      job_params = FactoryGirl.attributes_for :job, describe: nil
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
      expect(flash[:danger]).to be_present
    end
  end

  describe "PUT #update" do
    let(:admin){FactoryGirl.create :user, role: 1}
    let(:company){FactoryGirl.create :company}
    let(:job){FactoryGirl.create :job}

    before :each do
      allow(controller).to receive(:current_user).and_return(admin)
      sign_in admin
    end

    it "update successfully" do
      job_params = FactoryGirl.attributes_for :job, title: "something"
      put :update, params: {company_id: company, id: job, job: job_params}
      job.reload
      expect(job.title).to eq "something"
      expect(flash[:success]).to be_present
    end

    it "update fail" do
      title = FFaker::Lorem.paragraph
      job_params = FactoryGirl.attributes_for :job, title: title
      put :update, params: {company_id: company, id: job, job: job_params}
      expect(flash[:danger]).to be_present
    end
  end
end
