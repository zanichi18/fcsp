require "rails_helper"

RSpec.describe UserLinksController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:user_link){FactoryGirl.create :user_link, user: user}
  before do
    sign_in user
  end

  describe "GET #new" do
    it do
      get :new, format: :js, xhr: true
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "created user link successfully" do
      post :create, params: {user_link: {link: "http://facebook.com"}},
        format: :js, xhr: true
      expect(assigns(:flash).message)
        .to eq I18n.t("user_links.create.success")
      expect(assigns(:flash).status).to eq 200
    end

    it "created user link failed" do
      post :create, params: {user_link: {link: "abc"}},
        format: :js, xhr: true
      user_link = user.user_links.create link: "abc"
      expected = {errors: user_link.errors.messages}.to_json
      expect(response.body).to eq expected
    end
  end

  describe "GET #edit" do
    it do
      get :edit, params: {id: user_link}, format: :js, xhr: true
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "updated user link successfully" do
      patch :update, params: {id: user_link, user_link: {link: "http://fb.me"}},
        format: :js, xhr: true
      expect(assigns(:flash).message)
        .to eq I18n.t("user_links.update.success")
      expect(assigns(:flash).status).to eq 200
    end

    it "updated user link failed" do
      patch :update, params: {id: user_link, user_link: {link: "abc"}},
        format: :js, xhr: true
      user_link.update_attributes link: "abc"
      expected = {errors: user_link.errors.messages}.to_json
      expect(response.body).to eq expected
    end
  end

  describe "DELETE #destroy" do
    it "deleted user link successfully" do
      delete :destroy, params: {id: user_link}, format: :js, xhr: true
      expect(assigns(:flash).message)
        .to eq I18n.t("user_links.destroy.success")
      expect(assigns(:flash).status).to eq 200
    end
  end
end
