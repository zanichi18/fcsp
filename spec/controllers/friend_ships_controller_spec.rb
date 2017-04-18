require "rails_helper"

RSpec.describe FriendShipsController, type: :controller do
  let!(:user1){FactoryGirl.create :user}
  let!(:user2){FactoryGirl.create :user}

  before :each do
    sign_in user1
  end

  context "POST #create" do
    it "send a request" do
      expect do
        post :create, xhr: true, params: {id: user2.id}
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
        params: {id: user2.id}
      end.to change(Friendship, :count).by -2
    end

    before do
      user1.friend_request user2
      user2.accept_request user1
    end
    it "unfriend" do
      expect do
        delete :destroy, xhr: true,
        params: {id: user2.id, is_unfriend: true}
      end.to change(Friendship, :count).by -2
    end
  end

  describe "PATCH #update" do
    before do
      user2.friend_request user1
    end

    context "with valid attributes" do
      it "update request friend success with accept" do
        patch :update, xhr: true,
          params: {id: user2.id, status: Settings.friend_ship.accept},
          format: :json
        expect(response.body).to eq({message:
          I18n.t("friend_ships.update.success")}.to_json)
      end

      it "update request friend success with decline  " do
        patch :update, xhr: true,
          params: {id: user2.id, status: Settings.friend_ship.decline},
          format: :json
        expect(response.body).to eq({message:
          I18n.t("friend_ships.update.reject_success")}.to_json)
      end
    end

    context "cannot load user" do
      before do
        allow(User).to receive(:find_by).and_return(nil)
        get :update, params: {id: 100, status: 2}
      end

      it "redirect to root_path" do
        expect(response).to redirect_to root_path
      end

      it "get a flash danger" do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
