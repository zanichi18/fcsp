require "rails_helper"

RSpec.describe InfoUsersController, type: :controller do
  let!(:user){FactoryGirl.create :user}

  before do
    sign_in user
  end

  describe "PATCH #update" do
    it "updated successfully" do
      info_user = user.build_info_user(introduce: "introduce default")
      info_user.save
      patch :update, params: {id: info_user.id,
        info_user: {introduce: "introduce changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).introduce)
        .to eq "introduce changed"
    end

    it "updated fail when not login" do
      sign_out user
      info_user = user.build_info_user(introduce: "introduce default")
      info_user.save
      patch :update, params: {id: info_user.id,
        info_user: {introduce: "introduce changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).introduce)
        .not_to eq "introduce changed"
    end
  end
end
