require "rails_helper"

RSpec.describe InfoUsersController, type: :controller do
  let!(:user){FactoryGirl.create :user}

  before do
    sign_in user
  end

  describe "PATCH #update" do
    it "updated introduce successfully" do
      info_user = FactoryGirl.create :info_user, user: user
      patch :update, params: {id: info_user.id,
        info_user: {introduce: "introduce changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).introduce)
        .to eq "introduce changed"
    end

    it "updated introduce fail when not login" do
      sign_out user
      info_user = FactoryGirl.create :info_user, user: user
      patch :update, params: {id: info_user.id,
        info_user: {introduce: "introduce changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).introduce)
        .not_to eq "introduce changed"
    end

    it "updated ambition successfully" do
      info_user = FactoryGirl.create :info_user, user: user
      patch :update, params: {id: info_user.id,
        info_user: {ambition: "ambition changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).ambition)
        .to eq "ambition changed"
    end

    it "updated ambition fail when not login" do
      sign_out user
      info_user = FactoryGirl.create :info_user, user: user
      patch :update, params: {id: info_user.id,
        info_user: {ambition: "ambition changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).ambition)
        .not_to eq "ambition changed"
    end

    it "updated quote successfully" do
      info_user = FactoryGirl.create :info_user, user: user
      patch :update, params: {id: info_user.id,
        info_user: {quote: "quote changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).quote)
        .to eq "quote changed"
    end

    it "updated quote fail when not login" do
      sign_out user
      info_user = FactoryGirl.create :info_user, user: user
      patch :update, params: {id: info_user.id,
        info_user: {quote: "quote changed"}}, xhr: true
      expect((InfoUser.find_by id: info_user.id).quote)
        .not_to eq "quote changed"
    end
  end
end
