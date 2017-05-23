require "rails_helper"

RSpec.describe SkillUsersController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:skill){FactoryGirl.create :skill, name: "Ruby"}
  let!(:skill_user){FactoryGirl.create :skill_user, user: user, skill: skill}
  before do
    sign_in user
  end

  describe "GET #index" do
    it "render skill user index when search" do
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
    it "created user skill successfully" do
      post :create, params: {skill_user: {skill: "Ruby"}},
        format: :js, xhr: true
      expect(assigns(:render).message)
        .to eq I18n.t("skill_users.create.success")
      expect(assigns(:render).status).to eq 200
    end

    it "created skill user failed" do
      expect do
        post :create, params: {skill_user: {skill: ""}},
        format: :js, xhr: true
        @skill_user = user.skill_users.create level: ""
      end.to change(UserLanguage, :count).by 0
    end
  end

  describe "GET #edit" do
    it do
      get :edit, params: {id: skill_user}, format: :js, xhr: true
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "updated skill user successfully" do
      patch :update, params: {id: skill_user,
        skill_user: {skill: "Ruby"}}, format: :js, xhr: true
      expect(assigns(:render).message)
        .to eq I18n.t("skill_users.update.success")
      expect(assigns(:render).status).to eq 200
    end
    it "updated skill user failed" do
      patch :update, params: {id: skill_user, skill_user: {skill: ""}}
      skill_user.reload
      expect(skill_user.skill.name).to eq "Ruby"
    end
  end

  describe "DELETE #destroy" do
    it "deleted skill user successfully" do
      delete :destroy, params: {id: skill_user}, format: :js, xhr: true
      expect(assigns(:render).message)
        .to eq I18n.t("skill_users.destroy.destroy_success")
      expect(assigns(:render).status).to eq 200
    end
  end
end
