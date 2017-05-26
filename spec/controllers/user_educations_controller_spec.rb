require "rails_helper"

RSpec.describe UserEducationsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:school){FactoryGirl.create :school}
  let!(:user_education){FactoryGirl.create :user_education, user: user}
  before do
    sign_in user
  end

  describe "GET #index" do
    it "render index when search" do
      get :index, params: {search: "abc"}, format: :js, xhr: true
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it do
      get :new, format: :js, xhr: true
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "created user education successfully" do
      post :create, params: {user_education: {school: "BKDN"}},
        format: :js, xhr: true
      expect(assigns(:flash).message)
        .to eq I18n.t("user_educations.create.success")
      expect(assigns(:flash).status).to eq 200
    end

    it "created user education failed" do
      post :create, params: {user_education: {school: ""}},
        format: :js, xhr: true
      user_education = user.user_educations.create school_id: ""
      expected = {errors: user_education.errors.messages}.to_json
      expect(response.body).to eq expected
    end
  end

  describe "GET #edit" do
    it do
      get :edit, params: {id: user_education}, format: :js, xhr: true
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "updated user education successfully" do
      patch :update, params: {id: user_education,
        user_education: {school: "BKHN"}}, format: :js, xhr: true
      expect(assigns(:flash).message)
        .to eq I18n.t("user_educations.update.success")
      expect(assigns(:flash).status).to eq 200
    end

    it "updated user education failed" do
      patch :update, params: {id: user_education,
        user_education: {school: ""}}, format: :js, xhr: true
      user_education.update_attributes school_id: ""
      expected = {errors: user_education.errors.messages}.to_json
      expect(response.body).to eq expected
    end
  end

  describe "DELETE #destroy" do
    it "deleted user education successfully" do
      delete :destroy, params: {id: user_education}, format: :js, xhr: true
      expect(assigns(:flash).message)
        .to eq I18n.t("user_educations.destroy.success")
      expect(assigns(:flash).status).to eq 200
    end
  end
end
