require "rails_helper"

RSpec.describe FriendShipsController, type: :controller do
  let(:user1){FactoryGirl.create :user}
  let(:user2){FactoryGirl.create :user}

  before :each do
    sign_in user1
  end

  context "POST #create" do
    it "send a request" do
      expect do
        post :create, xhr: true, params: {user_id: user2.id}
      end.to change(Friendship, :count).by 2
    end
  end

  context "DELETE #destroy" do
    before do
      user1.friend_request user2
    end
    it "remove a request" do
      expect do
        delete :destroy, xhr: true,
        params: {id: user1.id, user_id: user2.id}
      end.to change(Friendship, :count).by -2
    end

    before do
      user1.friend_request user2
      user2.accept_request user1
    end
    it "unfriend" do
      expect do
        delete :destroy, xhr: true,
        params: {id: user1.id, user_id: user2.id, is_unfriend: true}
      end.to change(Friendship, :count).by -2
    end
  end
end
