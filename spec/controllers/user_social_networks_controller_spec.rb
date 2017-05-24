require "rails_helper"

RSpec.describe UserSocialNetworksController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before do
    sign_in user
  end

  describe "POST #create" do
    it "return json with success flash if successful create" do
      post :create, params: {social_network:
        "{\"facebook\":\"http://facebook.com\", \"google\":\"\",
        \"twitter\":\"\", \"linkedin\":\"\",
        \"skype\":\"\", \"youtube\":\"\",
        \"instagram\":\"\"}"}, format: :json, xhr: true
      expected =
        {flash: I18n.t("user_social_networks.create.success"),
        status: 200, link: {facebook: user.link_social_network("facebook"),
          google: user.link_social_network("google"),
          twitter: user.link_social_network("twitter"),
          linkedin: user.link_social_network("linkedin"),
          skype: user.link_social_network("skype"),
          youtube: user.link_social_network("youtube"),
          instagram: user.link_social_network("instagram")}}.to_json
      expect(response.body).to eq expected
    end

    it "return json with danger flash if fail create" do
      post :create, params: {social_network:
        "{\"facebook\":\"abc\", \"google\":\"\",
        \"twitter\":\"\", \"linkedin\":\"\",
        \"skype\":\"\", \"youtube\":\"\",
        \"instagram\":\"\"}"}, format: :json, xhr: true
      expected =
        {flash: I18n.t("user_social_networks.create.fail"),
        status: 400, link: nil}.to_json
      expect(response.body).to eq expected
    end
  end

  describe "PATCH #update" do
    before do
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 0, url: "http://fb.com"
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 1, url: nil
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 2, url: nil
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 3, url: nil
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 4, url: nil
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 5, url: nil
      FactoryGirl.create :user_social_network, owner: user,
        social_network_type: 6, url: nil
    end

    it "return json with success flash if successful update" do
      patch :update, params: {social_network:
        "{\"facebook\":\"http://facebook.com\", \"google\":\"\",
        \"twitter\":\"\", \"linkedin\":\"\",
        \"skype\":\"\", \"youtube\":\"\",
        \"instagram\":\"\"}"}, format: :json, xhr: true
      expected =
        {flash: I18n.t("user_social_networks.update.success"),
        status: 200, link: {facebook: user.link_social_network("facebook"),
          google: user.link_social_network("google"),
          twitter: user.link_social_network("twitter"),
          linkedin: user.link_social_network("linkedin"),
          skype: user.link_social_network("skype"),
          youtube: user.link_social_network("youtube"),
          instagram: user.link_social_network("instagram")}}.to_json
      expect(response.body).to eq expected
    end

    it "return json with danger flash if fail update" do
      patch :update, params: {social_network:
        "{\"facebook\":\"abc\", \"google\":\"\",
        \"twitter\":\"\", \"linkedin\":\"\",
        \"skype\":\"\", \"youtube\":\"\",
        \"instagram\":\"\"}"}, format: :json, xhr: true
      expected =
        {flash: I18n.t("user_social_networks.update.fail"),
        status: 400, link: nil}.to_json
      expect(response.body).to eq expected
    end
  end
end
