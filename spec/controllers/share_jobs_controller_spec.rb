require "rails_helper"

RSpec.describe ShareJobsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:job){FactoryGirl.create :job}

  before :each do
    sign_in user
  end

  describe "POST #create" do
    it "share job" do
      expect{post :create, params: {id: job}, xhr: true}
        .to change(ShareJob, :count).by 1
    end

    it "not share job without job" do
      post :create, params: {id: nil}, xhr: true
      expect{response}.to change(ShareJob, :count).by 0
    end

    it "share job fail" do
      FactoryGirl.create :share_job, user: user, job: job
      post :create, params: {id: job}, xhr: true
      expect{response}.to change(ShareJob, :count).by 0
    end
  end

  describe "DELETE #destroy" do
    let!(:share_job){FactoryGirl.create :share_job, user: user, job: job}
    context "delete successfully" do
      before{delete :destroy, params: {id: job}, xhr: true}
      it{expect{response.not_to change(ShareJob, :count)}}
    end

    context "delete fail" do
      it "unshare job fail" do
        share_job.destroy
        delete :destroy, params: {id: job}, xhr: true
        expect{response}.not_to change(ShareJob, :count)
      end
    end
  end
end
