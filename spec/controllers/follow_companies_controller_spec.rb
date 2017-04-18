require "rails_helper"

RSpec.describe FollowCompaniesController, type: :controller do
  let(:user){FactoryGirl.create :user}
  let!(:company){FactoryGirl.create :company}

  before :each do
    sign_in user
  end

  context "POST #create" do
    it "follow company" do
      expect do
        post :create, xhr: true, params: {company_id: company.id}
      end.to change(Follow, :count).by 1
    end
  end

  context "DELETE #destroy" do
    before do
      user.follow company
    end
    it "unfollow company" do
      expect do
        delete :destroy, xhr: true,
        params: {id: company.id, company_id: company.id}
      end.to change(Follow, :count).by -1
    end
  end
end
