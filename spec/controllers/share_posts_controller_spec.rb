require "rails_helper"

RSpec.describe SharePostsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:user_post){FactoryGirl.create :user_post}

  before :each do
    sign_in user
  end

  describe "POST #create" do
    it "share user post" do
      expect{post :create, params: {id: user_post}, xhr: true}
        .to change(ShareJob, :count).by 1
    end

    it "not share user post without user_post" do
      post :create, params: {id: nil}, xhr: true
      expect{response}.to change(ShareJob, :count).by 0
    end

    it "share user_post fail" do
      FactoryGirl.create :share_job, user: user
      post :create, params: {id: user_post}, xhr: true
      expect{response}.to change(ShareJob, :count).by 0
    end
  end

  describe "DELETE #destroy" do
    let!(:share_job) do
      FactoryGirl.create :share_job, user: user, shareable: user_post
    end
    context "delete successfully" do
      before{delete :destroy, params: {id: user_post}, xhr: true}
      it{expect{response.not_to change(ShareJob, :count)}}
    end

    context "delete fail" do
      it "unshare user_post fail" do
        share_job.destroy
        delete :destroy, params: {id: user_post}, xhr: true
        expect{response}.not_to change(ShareJob, :count)
      end
    end
  end
end
