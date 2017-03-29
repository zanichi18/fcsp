require "rails_helper"

RSpec.describe BookmarksController, type: :controller do
  let(:user){FactoryGirl.create :user}
  let!(:job){FactoryGirl.create :job}
  let!(:bookmark){FactoryGirl.create :bookmark, user: user, job: job}

  before :each do
    sign_in user
  end

  describe "POST #create" do
    it "bookmarked job" do
      post :create, params: {id: job}
      expect{user.bookmark job}.to change(Bookmark, :count).by 1
    end

    it "not bookmark job without job" do
      bookmark_params = FactoryGirl.create :job, id: nil
      post :create, params: {id: bookmark_params}
      expect{response}.to change(Bookmark, :count).by 0
    end
  end

  describe "DELETE #destroy" do
    context "delete successfully" do
      before{delete :destroy, params: {id: job}}
      it{expect{response.to change(Bookmark, :count).by -1}}
    end
  end
end
